Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E602C98
	for <mptcp@lists.linux.dev>; Mon, 25 Oct 2021 11:37:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1635161826; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=jK5OUrfMmTng5R5DlN5MLZT+MGVTLEokZabxiwhmFcWtHsUdOVFkXpw/dyq2FF3Q5HKRS8g4R8JjdVug59VD0Fw+5uVhJax2tSgbvEgmc6g3KDPhPC7vXdKAVhex9Dyy2l/KWNzkOfWPp3o2FgkMGvMx8JgRYeuChacAuM/3YrQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1635161826; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=5iuHFN0zrS6IZofca2KbhcJLC08o0nU4HFpSNvNb8jQ=; 
	b=fQTsgkqI26Ht/GWREkBrEgsfIcPtdqfH1ofHeusz8lL5WK/QV0KQ01tQRARh09ElmlvdUryOGj/QIvXnj7GLod/2DSIDVqHsoTQD/FUslz0TitlNAjp51GgwDrFAs/0DsdXpGxvgOLZ3G5Aemfw0zPjwx+q0LIG+wf20lehfP4g=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1635161826;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5iuHFN0zrS6IZofca2KbhcJLC08o0nU4HFpSNvNb8jQ=;
	b=H8r1A1wwWUyKPyy2cNzJIj9LZVnaq+qAealLjxHQJvNjjoh2watEo9AE7XY+QJzm
	uaGPyu3NQ4KO7C0bUxQh645JZ1PrRoMFa04uyphkXp3exHzl/TV6QTrC9Hr8EHy9lrL
	ANWUUyX4gNujrXefXMaKZzUZlmEAMhg1AOgDufpY=
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 1635161819235805.0404196321771; Mon, 25 Oct 2021 13:36:59 +0200 (CEST)
Date: Mon, 25 Oct 2021 13:36:59 +0200
From: Dmytro Shytyi <dmytro@shytyi.net>
To: "Mat Martineau" <mathew.j.martineau@linux.intel.com>
Cc: "Matthieu Baerts" <matthieu.baerts@tessares.net>,
	"mptcp" <mptcp@lists.linux.dev>
Message-ID: <17cb73d4861.11b42188b1729617.6331250551107235734@shytyi.net>
In-Reply-To: <b3fe9e5-cdc8-547d-f9b8-4565cd3b03e@linux.intel.com>
References: <17ca66cd439.10a0a3ce11621928.1543611905599720914@shytyi.net> <a52c4e6d-8463-6328-c786-9cb8b71ac62e@tessares.net> <b3fe9e5-cdc8-547d-f9b8-4565cd3b03e@linux.intel.com>
Subject: Re: [PATCH net-next v1] net: mptcp, Fast Open Mechanism
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail


---- On Fri, 22 Oct 2021 20:26:35 +0200 Mat Martineau <mathew.j.martineau@linux.intel.com> wrote ----

 > On Fri, 22 Oct 2021, Matthieu Baerts wrote: 
 >  
 > > Hi Dmytro, 
 > > 
 > > (without netdev ML and net maintainers) 
 > > 
 > > On 22/10/2021 07:15, Dmytro Shytyi wrote: 
 > >> This set of patches will bring "Fast Open" Option support to MPTCP. 
 > >> The aim of Fast Open Mechanism is to eliminate one round trip 
 > >> time from a TCP conversation by allowing data to be included as 
 > >> part of the SYN segment that initiates the connection. 
 > >> 
 > >> IETF RFC 8684: Appendix B.  TCP Fast Open and MPTCP. 
 > >> 
 > >> [PATCH v1] includes "client" partial support for : 
 > >> 1. send request for cookie; 
 > >> 2. send syn+data+cookie. 
 > >> 
 > >> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net> 
 > > 
 > > Again, thank you for looking at that! 
 > > 
 >  
 > Thanks for covering the patch submission and formatting guidelines, 
 > Matthieu. 
 >  
 > Dymtro, it will also be important to add some 'fast open' coverage to the 
 > kernel self tests in this directory of the kernel source tree: 
 >  
 > tools/testing/selftests/net/mptcp/ 
 >  
 > There's a short guide to running these tests at 
 > https://github.com/multipath-tcp/mptcp_net-next/wiki/Testing#kselftest 

Hello Mat,

I will add 'fast open' coverage to the kernel self tests.
Thank you for pointing that out.
 >  
 > We appreciate your work to add this feature to MPTCP in the Linux kernel! 
Thanks!

Take care,
Dmytro SHYTYI

 > -- 
 > Mat Martineau 
 > Intel 
 > 
