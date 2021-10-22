Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A838F2CA2
	for <mptcp@lists.linux.dev>; Fri, 22 Oct 2021 08:21:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1634890893; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Vk05yGHbuHInKbz4AhMglQ73glPTR7CAfOJDtv4PNTGuv7y8xuveJux5XAu7dZ4pb3CNhqp//+lWjA4es9Kf3aepfdktMAgFi3JOTSmJzL6bakcsGrDwPE4xJHKVmQSTKYZN9baBpfzZQ0PyE7l/+tnMCMSj6mlbsUrJNZHcngI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1634890893; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=kEnBidR+MgDK3v1eZly6Qy7jRnbayGcl3R6v5+tw1ik=; 
	b=hOMMbiWWxljvUwR7hPhgd4K+/ZZF3wJIBbhC5eo0cAM6BFjekzT1m7QHaBKFOsWxbIO0XaCZ+NwXQGdu1ELl4iyzGwZlguweepmP8C0MPCWbiCNgtwZ+u2SsLJxBrpeN/dkncxEA/ffHyB9F/BAOBSnzG4igqamSNRPKhBLiABc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1634890893;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kEnBidR+MgDK3v1eZly6Qy7jRnbayGcl3R6v5+tw1ik=;
	b=evQX1kn4zKYP4rmkPM2PC4VN1YguOR+yH6Ccb/8cqbonkoRRGpxkRj3ZKnMYgxMU
	LTip+2qr6+fW0XnMthdvnFRLbkwXsW15xzRdxlgCiNG0WbsvXDsLKBKxamTPYLlTQ02
	4KrN0/oUugMJ7Og3xYl06j25rbqZ0UFvimptkWOI=
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 1634890886266675.0982695438471; Fri, 22 Oct 2021 10:21:26 +0200 (CEST)
Date: Fri, 22 Oct 2021 10:21:26 +0200
From: Dmytro Shytyi <dmytro@shytyi.net>
To: "Matthieu Baerts" <matthieu.baerts@tessares.net>
Cc: "mptcp" <mptcp@lists.linux.dev>
Message-ID: <17ca7172c79.edff7c501605824.3162476274453476852@shytyi.net>
In-Reply-To: <7323f833-08e7-5b90-6175-c88696b73e63@tessares.net>
References: <17ca66cd439.10a0a3ce11621928.1543611905599720914@shytyi.net> <7323f833-08e7-5b90-6175-c88696b73e63@tessares.net>
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

Hello Matthieu,

---- On Fri, 22 Oct 2021 09:22:05 +0200 Matthieu Baerts <matthieu.baerts@tessares.net> wrote ----

 > Hi Dmytro, 
 >  
 > On 22/10/2021 07:15, Dmytro Shytyi wrote: 
 > > This set of patches will bring "Fast Open" Option support to MPTCP. 
 > > The aim of Fast Open Mechanism is to eliminate one round trip 
 > > time from a TCP conversation by allowing data to be included as 
 > > part of the SYN segment that initiates the connection. 
 > > 
 > > IETF RFC 8684: Appendix B.  TCP Fast Open and MPTCP. 
 > > 
 > > [PATCH v1] includes "client" partial support for : 
 > > 1. send request for cookie; 
 > > 2. send syn+data+cookie. 
 >  
 > Thank you for working on that and sharing this patch with us! 

 Thank you for checking my patch!

 > It looks like some modifications are going to be needed, e.g. after a 
 > very quick look, it seems all tabs have been converted to spaces causing 
 > the patch not being applicable on git[1]: did you not use git 
 > format-patch to generate it? Also, some issues will be reported by 
 > checkpatch.pl, the "reversed XMas tree" order is not respected for 
 > variables declaration, etc. 

I used scripts/checkpatch.pl. I meant no disrespect, and checked 
the patch before submission. I will do it one more time before next submission.
I used "git diff". Thanks for pointing that out. I will use "git format-patch".



 > Do you mind if we continue the discussion on MPTCP mailing list only? In 
 > other words, without Netdev mailing list and Net maintainers, not to 
 > bother everybody for MPTCP specific stuff? 

 I do not mind. Starting from this message, this is only on mptcp list.
These mail addresses I got by executing ./scripts/get_maintainer.pl

 > Our usual way of working for MPTCP patches is to have the code review on 
 > MPTCP ML only, then apply accepted patches in our tree first and once a 
 > validation has been done, send patches later to Netdev ML for inclusion 
 > in the -net or net-next tree. 

Great,  

 > Cheers, 
 > Matt 

Take care,
Dmytro SHYTYI.

 >  
 > [1] 
 > https://patchew.org/logs/17ca66cd439.10a0a3ce11621928.1543611905599720914@shytyi.net/git/ 
 > -- 
 > Tessares | Belgium | Hybrid Access Solutions 
 > www.tessares.net 
 > 
