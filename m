Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7861F4190
	for <mptcp@lists.linux.dev>; Fri,  5 Sep 2025 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062831; cv=none; b=utJlzzzHQhltyXSzMzAldPK86eJQNYsEb58N+yGxN/a4/fKb+SnoB8L8dw7hUmOolsP2urw56X++PBxeEs2zzk0Y+QX6lxEEiUEPEdbl/v7Z5KWE5ZTcVAsbHC5d1MHKPsOmE3B66EgwhJQcXi8sGs3ck2PxKZEQln77JtzjsLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062831; c=relaxed/simple;
	bh=sX5+iKnEPZtgzup2fJOaFwSt/b4LZT9+FWhEQKYxa+0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BKN2E0PHPCn1z3XFRPTAqwRaJnPy+1xcbikS9RphkQqUqHoDgIhdiA7L88Y66XKoYilEsu1L1GK4iLYqG/h1xVqZucrn4A6tWdo8cFJJN23wkqgu2C5J7QuKcyGt7rIkLFJZcWwMSVrpW8xKzJqCfuoRBYH8PHbcpGNecq9kujQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obbHgR2q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obbHgR2q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB6DC4CEF1;
	Fri,  5 Sep 2025 09:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757062830;
	bh=sX5+iKnEPZtgzup2fJOaFwSt/b4LZT9+FWhEQKYxa+0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=obbHgR2qzp9nSvKcyo0+hXtMBVoEM2YctMDSVZ4MHsxjF3Dd1vBb8Zg4DT5NXCpZs
	 oE4jRZF+5xptltZek4gISQ86SLoPaGhDiH4flFY/e6lHp3Lb4Cpy/yF3AV+2NU0G/z
	 bkEhPrEwBCmWixdEn2f3Qn0zVb9772JJaSenJaCf27omoqwWhW1GcMB/VBIBkYntjQ
	 st2uF0cm0NZkwUOz86fdgWh6iPPaNVtzVPgn3awoFTUPK/eGWOqw+WYPwSUCMgK4X1
	 iS8PG1HaFrgPsMCoxYignw9WCmG+N9NaQQdhaC+3HaBkavrjh87IVzW7gSqmtjS38B
	 FqUhoRg3LJv8g==
Message-ID: <cd91d2ed160abe3e5b99b06ed985c8d0dddf1b20.camel@kernel.org>
Subject: Re: Add Multipath TCP (MPTCP) Support to the Java Networking API
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>,  Gang Yan <yangang@kylinos.cn>, Xiang Gao
 <gaoxiang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Date: Fri, 05 Sep 2025 17:00:20 +0800
In-Reply-To: <00cc9a4fa008cd346c8c12a044d5c41b5af58a6f.camel@kernel.org>
References: <00cc9a4fa008cd346c8c12a044d5c41b5af58a6f.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I just received a message that this email was not delivered: Your
message to net-dev awaits moderator approval, reason: Post by non-
member to a members-only list. So I had to subscribe to the openjdk
net-dev and core-libs-dev mailing lists and resend the email.

If you want to reply to this email in the future, please subscribe to
these two mailing lists before replying:

https://mail.openjdk.org/mailman/listinfo/net-dev
https://mail.openjdk.org/mailman/listinfo/core-libs-dev

Thanks,
-Geliang

On Fri, 2025-09-05 at 09:43 +0800, Geliang Tang wrote:
> Hi OpenJDK maintainers,
> 
> I hope this message finds you well. The purpose of this letter is to
> propose the integration of Multipath TCP (MPTCP) support into
> OpenJDK.
> We have developed a set of patches to enable this functionality and
> are
> eager to submit it for upstream inclusion. We would greatly
> appreciate
> your feedback and opinions on this contribution.
> 
> 1. Introduction
> 
> Multipath TCP (MPTCP), as standardized in RFC 8684, is a major
> evolution of the TCP protocol. It enables a transport connection to
> use
> multiple network paths simultaneously for redundancy, resilience, and
> bandwidth aggregation. Since its introduction in Linux kernel v5.6,
> it
> has become a key technology for modern networking, particularly on
> mobile devices with multiple interfaces (e.g., Wi-Fi and cellular).
> 
> Key benefits include:
> 
>     Bandwidth Aggregation: Combine the bandwidth of multiple network
> links.
> 
>     Seamless Handover: Maintain connections when switching networks
> without dropping the session.
> 
>     Improved Resilience: Traffic is automatically rerouted if one
> path
> fails.
> 
> For more details, see the project website: https://mptcp.dev.
> 
> 2. Technical Background
> 
> On a supporting system like Linux, an MPTCP socket is created by
> specifying the IPPROTO_MPTCP protocol in the socket() system call
> instead of IPPROTO_TCP (or 0):
> 
>     int fd = socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);
> 
> This creates a socket that looks like a standard TCP socket to the
> application but uses the MPTCP protocol stack underneath.
> 
> With the Java API, it is possible to create "stream" sockets, but it
> is
> not possible to change the last argument, which blocks apps to ask to
> use MPTCP.
> 
> 3. Proposed Java API Changes
> 
> The goal is to allow Java applications to opt-in to using MPTCP when
> creating sockets, without breaking existing code. The proposed
> changes
> are additive and backward-compatible.
> 
> The core idea is to add a boolean mptcp parameter through the API
> layers, from the public Socket class down to the native system call.
> 
> 4. Implementation Plan
> 
> The implementation involves changes across four layers of the JDK:
> 
> JNI Layer (sun.nio.ch.Net):
> 
> Modify Java_sun_nio_ch_Net_socket0 to accept a new jboolean mptcp
> parameter.
> 
>     The native implementation will be updated to use this parameter:
> 
>     int protocol = mptcp == JNI_TRUE ? IPPROTO_MPTCP : 0;
>     fd = socket(domain, type, protocol);
> 
> NIO Layer (sun.nio.ch):
> 
>     Add the mptcp parameter to the Net.socket() and
> Net.serverSocket()
> methods.
> 
>     Propagate the parameter down to the JNI call.
> 
> Socket Implementation Layer (java.net):
> 
>     Add the mptcp parameter to the constructor of NioSocketImpl.
> 
>     Within NioSocketImpl, pass the parameter to the Net.socket() or
> Net.serverSocket() calls.
> 
> Public API Layer (java.net.Socket & java.net.ServerSocket):
> 
>     Add new constructors that accept the mptcp parameter.
> 
>     Example:
> 
>         // Proposed new constructor
>         public Socket(String host, int port, boolean stream, boolean
> mptcp) throws IOException {
>             // ... implementation that passes 'mptcp' to
> NioSocketImpl
>         }
> 
> 5. Full Implementation
> 
> The complete working implementation for this proposal is available
> for
> review:
> 
> https://github.com/openjdk/jdk/compare/master...geliangtang:jdk:master
> 
> We look forward to your valuable feedback and suggestions on this
> proposal.
> 
> we can create a new issue for this feature, and submit a proper pull
> request after if that's OK for you. We didn't do that yet because we
> noticed that it is recommended to send more explanations to this list
> first.
> 
> Best regards,
> MPTCP Upstream Developers
