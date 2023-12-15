Received: from fallback18.i.mail.ru (fallback18.i.mail.ru [79.137.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15163DB93
	for <mptcp@lists.linux.dev>; Fri, 15 Dec 2023 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=internet.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=internet.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=internet.ru header.i=@internet.ru header.b="ORbIBZYj";
	dkim=pass (2048-bit key) header.d=internet.ru header.i=@internet.ru header.b="frRqpyaC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=internet.ru; s=mail4;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=UJiegAHWifgTNTGSIGaEJbUFAGk9DIIQX27czSc6OsY=;
	t=1702653186;x=1702743186; 
	b=ORbIBZYj1bUKpsv4FmjoE7OAcIgB+j0JL2C4f6pW4Fk0Lv3M9RIiGUVze2mPwWVZXhp/qsHbUuqk1cM1SAhQyGa1cEr8C2nUbLnms7XbJk/5V0l11lO/zzBuNam2hllSUi74XK8u3dmIF6tEvB7Cz83d683yOIwb6WEz7kP9POdTdF3ssvuaIrd4JWWKTfnX1G2ednFqwUpcwf0+d20C8zccaNQb8s8bBpeb+0xJHh+cJzANQl5Dlg/BeThSmthY2op7dQjp70Xa7j4u/e7MBEdUsWpIwYxgnTRL3ds7xWNNGu+Gwf/u4PV2SsmoudOBeY3feN4nVTYoLsYVsXwlfw==;
Received: from [10.12.4.36] (port=33206 helo=smtp59.i.mail.ru)
	by fallback18.i.mail.ru with esmtp (envelope-from <max@internet.ru>)
	id 1rE8yE-00G29U-Fv
	for mptcp@lists.linux.dev; Fri, 15 Dec 2023 17:15:18 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=internet.ru
	; s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To
	:Cc:Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=UJiegAHWifgTNTGSIGaEJbUFAGk9DIIQX27czSc6OsY=; t=1702649718; x=1702739718; 
	b=frRqpyaCiGE+bRWnItxFnIhC+mbPS4wgY0P4263cxAWdyx+LlSlQUrkT1DV9dzW1jYlBY7t2fco
	JLqCDfM1QP6Ydc3Jfwqrzx9RbfVByPFshV7DxSi+2vmztuvfwLqnqe7YqF8rpUvDxRFbg3sVmozVM
	nhJ39rzE2hOrDnTBdTBbm1MGOtoueO6uT8qU+GcIcA4ornkOpc3uW8vemqygXAnyyko8sfG0YWlhb
	Jg/QdG/rEDpVMFWfNsS0QAZqs6uUM4nTrpsVu6PP0NCDZFruB8hWa8HPMTKmgqtBxrQ71YSaM2yi/
	iBiwWFfmFLfjN74xR4YqedIHgpzicWNrr/9Q==;
Received: by smtp59.i.mail.ru with esmtpa (envelope-from <max@internet.ru>)
	id 1rE8xz-0092nt-06; Fri, 15 Dec 2023 17:15:03 +0300
Message-ID: <98dd35f4-8e96-4916-99c2-f8687dd66f75@internet.ru>
Date: Fri, 15 Dec 2023 17:15:02 +0300
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 mptcp-next 0/3] more sockopts for ephemeral ports
To: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20231211120309.20752-1-max@internet.ru>
 <4ed1d1bb-dfb3-4533-8a84-8aa40b002df4@kernel.org>
Content-Language: en-US
From: Maxim Galaganov <max@internet.ru>
In-Reply-To: <4ed1d1bb-dfb3-4533-8a84-8aa40b002df4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9B1592A052B88CCADA8593BE3AFB895B57F888ED933B199AE1313CFAB8367EF908E2BE116634AD74DBE68FBD5210DADB7C72F1657C2F732FB72E9CBBF66E331629799EF890AE2FAA9
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7B9FBA884A7C9B8BAEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063779089FB2CE4EA2908638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D88F7DD63B41CE3AB53CACAFEC9581F58B6F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE7A6779F98BF527B7A9FA2833FD35BB23D9E625A9149C048EE26055571C92BF10F2CC0D3CB04F14752D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8B47272755C61AA17BA471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FCE3B78367742D7E3B3AA81AA40904B5D9CF19DD082D7633A0C84D3B47A649675F3AA81AA40904B5D98AA50765F79006376A29911348193673D81D268191BDAD3D3666184CF4C3C14F3FC91FA280E0CE3D1A620F70A64A45A98AA50765F7900637F1CEADB5F7626D0D6D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F7900637C69D4C8FA58DAC3AEFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A53E84F1C8991B4F28AF097266FADD59314107E9D325393395F87CCE6106E1FC07E67D4AC08A07B9B065B78C30F681404DCB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D349C39CCCDAABCB54B76D12DE5D4BB0F62D60E2D5B84FDAD33F54308D1F7200C194AA887098F7206C31D7E09C32AA3244C6C5146ABA204F5765E1895B0AAAD56ADCE0B41342B755BCD85A42E4C463514DC5DA084F8E80FEBD3D5501401B63CC304BBF986B66403E88043082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojqTOLJuiq3hbgA1683jb1Cw==
X-Mailru-Sender: 7766D515518070DED5E1F59BD085B5D44AC57CFC855392CDF350E3A588D525A0481B2AED7BCCC0A4AA92DCB28147B367B60569B44082A3A3CC338593878DF048773EBFF2F43C11D6EAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4504CF8691E74CC1EE045C20511AAF4EE1D341FAC50A8319C049FFFDB7839CE9E4B8DEBCACA35BB8A9F3614F772D09217D1A08BC0D0DA5C6D8F5468140AE0734D
X-7FA49CB5: 0D63561A33F958A57CD46F4F0F529B0ECB7F5E8A12FADCEBB24B92A7F657E91ECACD7DF95DA8FC8BD5E8D9A59859A8B6A096F61ED9298604
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdfQ7/oSSXYuQXTwRPvMVObg==
X-Mailru-MI: C000000000000800
X-Mras: Ok

On 15.12.2023 16:56, Matthieu Baerts wrote:
> Hi Maxim, Mat,
> 
> On 11/12/2023 13:03, Maxim Galaganov wrote:
>> Support useful sockopts that allow fine control over ephemeral port
>> usage.
>>
>> v3:
>>   - Change patch 2/3 with regards to commit d9f28735af87 ("Use
>>     READ/WRITE_ONCE() for IP local_port_range.")
>>   - Drop Mat's Reviewed-By tag in patch 2/3 because of changes
> 
> Thank you for the patches and the reviews!
> 
> Please note that 'b4' is telling me that your emails are not properly
> signed by your SMTP server:
> 
>    BADSIG: DKIM/internet.ru
> 
> That's not blocking here, but it could be a sign someone is trying to
> forge the sender address.

This is because of DKIM expiration (DKIM-Signature header contains t= 
and x= tags, that make signature invalid after some time). It is 
reasonably effective to prevent DKIM replay attacks, also can be done by 
rotating DKIM selectors (gmail does that, IIRC).

Running b4 with -d flag tells:
DKIM: x= value is past (b'1702386232')

Otherwise header and body hashes should verify OK here..

> 
> These patches have been added in our tree: feat. for net-next.
> 
> New patches for t/upstream:
> - 250382904050: mptcp: rename mptcp_setsockopt_sol_ip_set_transparent()
> - be6fee83fad1: mptcp: sockopt: support IP_LOCAL_PORT_RANGE and
> IP_BIND_ADDRESS_NO_PORT
> - 5df30926310b: selftests/net: add MPTCP coverage for IP_LOCAL_PORT_RANGE
> - Results: e2b8a59f008f..84d8fb414b2a (export)
> 
> Tests are now in progress:
> 
> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20231215T134806
> 
> Cheers,
> Matt

