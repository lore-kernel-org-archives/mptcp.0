Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCDE271447
	for <mptcp@lists.linux.dev>; Thu, 10 Jul 2025 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160747; cv=none; b=VB+aF3TzqqmJ+8oUkXsgFDF7wKE6WFaZNOhJ2CEnUUIu+Dd/mpj5Q/0Bsc2NVzcpEdjb71DQqjHIaM5afo8PLibZ/0OAcphyawaq2fSBfGK+P0QQ4dRXw/TTgu0NeCuaFJcNcoFtgy9ZPPOdaa4r6vD0tq3sPeIqK5uqvfZttoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160747; c=relaxed/simple;
	bh=TVYHQfZ6pUZjg60xBENVzW1r6SziW0p9IIWa1GlcrTI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=UGPoNMYj4H0d3Xzy8aaHALBPNh9+uHxKdAFKoW+DtiN6SH4GFamltJfOec4O4OKZqVs35/UL1Q7OxR+f22JGyZwwpa2z7vu/xL7ecwVgA1OaySGElTRexFAxZ5OZ/D14kJhCKfxatG+gmpI3pIrIjt/YL6C1ZXaaUD/8SMQ4s48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzUZbXX4; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzUZbXX4"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6face367320so9880236d6.3
        for <mptcp@lists.linux.dev>; Thu, 10 Jul 2025 08:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752160745; x=1752765545; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zm+9oR2davHLi5aKZdMFhF4TD8r/IuTE32QU8csXds=;
        b=bzUZbXX4MgP2BdYay82sCSWQppIwm0ZBG+BJMAUKs8jrkkoJ+D6Q2fb72UFdRpu52k
         r//H4su3Vjjr/EGqseFwn64csTQNv9Cjltf1t5yG84Aqz/mfEKGpwYubIL3dyLw3d1M9
         vBHnVmmqTL2PGMwo5IXyvp1aF2mitm1TGF3h27W6rIFGcvF5HbBYGMbkOMAyihQWDSTl
         E97Ix6d1k0DuGYGqKBBwv1bf8RWOLrTYe5rHF7z0zCH/NIUaTCj6Jf2rrqsgsaNsbLQw
         YdGw5Qv34arcN1rzjl/9EopySDQL9eSQR1nYrgtcIK4J8U9I5BzejGJ8PKQaIG2P80BB
         pgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752160745; x=1752765545;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7zm+9oR2davHLi5aKZdMFhF4TD8r/IuTE32QU8csXds=;
        b=sXUUoPCFJ7mQdzt93tBUWKPQjYr6M7gSc+ToVc4o48LeznVhH4BIwd375idevUxe8e
         CGlAKY5n3HGwtsLvkh/i7cWnLsdOhcLMtX5oLMw/BDRSw8XuWdHraq6cXfHA4MQUGFke
         ISNVYKcl0mC7votXEwzHhJEAMSuHhCAA8uvK+skP6bb806kB4pSueAoODhKfxQ1P323x
         x/XkSB2QXW/iycmET6yCwzuKXZIFyukpk1HoooK73x6yqUP623BXpdJIhvg9VrJ/bQaZ
         F9ho4alQRtuXVRfrWLx5UZ067HpSi5w2Zg5dpIEuWYLyrNfp++cTkB5G5/ScjoMvtCxW
         E1GA==
X-Gm-Message-State: AOJu0YyDCH9acbiQMlszLYurbKpBIbfPT/xUa/5b1QOObn4x+flwPj2T
	gtOuSK/TONFVItysOYZ0mWPTxp/OFjmBmY46t3H1MXz7DLdZb6FaeaaVZztl
X-Gm-Gg: ASbGncsj417XW//r31Z7hbOEgWiV2En5/xWHUhQXA2Nya4AEqXGwh8oU55apI0ULxOc
	GahbbU5NdcRpbz0y9JeHCpqhR5P1VL4bSWZzzGTcSW0kkdQ/4Q5hPZary43CBTCvQ9XZW1XLvqK
	W/7oNoW9X+H0y7kV4vaXspzpXyIQz0Ok/bKjwf/xjqcoP1qyV9vAGm7ozCrOjdQkpJ9bhBWWM/Z
	6qE2+vyWJ6N4D2zLyWXLJm1y+TmX0UbnGzDopt+cxEO1GX3V6cSjbhSRw4eXwT8qiOZhCDV4PF7
	ggWHunQAfkmEXDTSVpHem5erozko6mJt1pztVPuS30JXzIiGKWExMHoAq3GkOvEskizIT360pEP
	V
X-Google-Smtp-Source: AGHT+IGLWYeifYb103h4aP3eLVUQYZFQewloNRT9AIgmTiLvk5ge9d1Ls39eQ8+J5y188Za0rNVDNA==
X-Received: by 2002:ad4:5ca4:0:b0:6fb:3579:8f07 with SMTP id 6a1803df08f44-70495023e97mr67283506d6.31.1752160744927;
        Thu, 10 Jul 2025 08:19:04 -0700 (PDT)
Received: from [127.0.0.1] ([104.211.34.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d39445sm9334086d6.56.2025.07.10.08.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:19:04 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1752141057.git.tanggeliang@kylinos.cn>
References: <cover.1752141057.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v3_0/2=5D_Squa?=
 =?UTF-8?Q?sh_to_=22implement_mptcp_read=5Fsock=22_?= =?UTF-8?Q?v8?=
Message-ID: <e87f2808-4533-c3f2-c43a-b6eda1c152a8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Jul 2025 15:19:03 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/16198880454

Status: failure
Initiator: Matthieu =
Baerts (NGI0)
Commits: https://github.com/multipath-tcp/mptcp_net-next/comm=
its/8d1d0792ca2d
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D980943

Feel free to reply to this email =
if you cannot access logs, if you need
some support to fix the error, if =
this doesn't seem to be caused by your
modifications or if the error is a =
false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu =
Baerts (NGI0 Core)
