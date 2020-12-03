package kr.co.controller;

import javax.management.RuntimeErrorException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.service.MemberService;
import kr.co.vo.MemberVO;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService service;
	
	@Autowired
	BCryptPasswordEncoder pwdEncoder;
	
	//회원가입 GET
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void getRegister() throws Exception {
		logger.info("getRegister");
		
	}
	
	//회원가입 POST
	@RequestMapping(value ="/register", method = RequestMethod.POST)
	public String postRegister(MemberVO vo) throws Exception {
		logger.info("postRegister");
		
		int result = service.idChk(vo);
		
		try {
			if(result == 1) {
				return "/member/register";
			} else if(result == 0) {
				
				String inputPass = vo.getUserPass();
				String pwd = pwdEncoder.encode(inputPass);
				vo.setUserPass(pwd);
				
				service.register(vo);
			}
		} catch(Exception e) {
			throw new RuntimeException();
		}
		
		return "home";
	}
	
	//로그인
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(MemberVO vo, HttpSession session, RedirectAttributes rttr) throws Exception {
		logger.info("login");
		
		session.getAttribute("member");
		MemberVO login = service.login(vo);
		boolean pwdMatch = pwdEncoder.matches(vo.getUserPass(), login.getUserPass());
		
		if(login != null && pwdMatch == true) {
			session.setAttribute("member", login);
		} else {
			session.setAttribute("member", null);
			rttr.addFlashAttribute("msg", false);
		}
		
		return "redirect:/";
	}
	
	//로그아웃
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String logout(HttpSession session) throws Exception {
		
		session.invalidate();
		
		return "redirect:/";
	}
	
	//회원정보수정 GET
	@RequestMapping(value = "/memberUpdateView", method = RequestMethod.GET)
	public String memberUpdateView() throws Exception {
		logger.info("memberUpdateView");
		
		return "member/memberUpdateView";
	}
	
	//회원정보수정 POST
	@RequestMapping(value = "/memberUpdate", method = RequestMethod.POST)
	public String memberUpdate(MemberVO vo, HttpSession session) throws Exception {
		logger.info("memberUpdate");
		
		service.memberUpdate(vo);
		
		session.invalidate();
		
		return "home";
	}
	
	//회원탈퇴 GET
	@RequestMapping(value = "memberDeleteView", method = RequestMethod.GET)
	public String memberDeleteView() throws Exception {
		logger.info("memberDeleteView");
		
		return "member/memberDeleteView";
	}
	
	//회원탈퇴 POST
	@RequestMapping(value = "/memberDelete", method = RequestMethod.POST)
	public String memberDelete(MemberVO vo, HttpSession session, RedirectAttributes rttr) throws Exception {
		logger.info("memberDelete");
		
		/*
		 * //세션에 있는 member를 가져와 member변수에 넣어준다 MemberVO member = (MemberVO)
		 * session.getAttribute("member");
		 * 
		 * //세션에 있는 비밀번호 String sessionPass = member.getUserPass();
		 * 
		 * //vo로 들어오는 비밀번호 String voPass = vo.getUserPass();
		 * 
		 * if(!(sessionPass.equals(voPass))) { rttr.addFlashAttribute("msg", false);
		 * return "redirect:/member/memberDeleteView"; }
		 */
		
		service.memberDelete(vo);
		session.invalidate();
		
		return "redirect:/";
	}
	
	//패스워드 체크
	@ResponseBody
	@RequestMapping(value = "/passChk", method = RequestMethod.POST)
	public boolean passChk(MemberVO vo) throws Exception {
		logger.info("passChk");
		
		MemberVO login = service.login(vo);
		boolean pwdChk = pwdEncoder.matches(vo.getUserPass(), login.getUserPass());
		
		
		return pwdChk;
	}
	
	//아이디 중복 체크
	@ResponseBody
	@RequestMapping(value = "/idChk", method = RequestMethod.POST)
	public int idChk(MemberVO vo) throws Exception {
		logger.info("idChk");
		
		int result = service.idChk(vo);
		
		return result;
	}
	
}
