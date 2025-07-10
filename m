Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042B128A1D4
	for <mptcp@lists.linux.dev>; Thu, 10 Jul 2025 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135060; cv=none; b=MBH5Yr/F2xiNzsmABSZcBJHhw4OluJNggElk56+K+bdbac6srfw7poUwdhtlbuM+O2aj3tGE/zD/KqPeSC99qicPmy3A/Vda/mfMmcsZoujbgbcjy50mVPV0peuWpFEN6VcJLVb9LPEveknfrcMcFLx94EjLhC8aO6Xks1qSSPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135060; c=relaxed/simple;
	bh=0GRvdJ/FtNECIKjPBA2rIOL2WmK3WTTBzgX2O75GULI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=X2MayvucyJWwzJxbXxmgGOJN67MaQGKEaBUQKf1T7egvDUA2XUCZwifZpzX3Vnf710krFSwt3ioiPt6g6XY3Qz/Oia4o0jqqcQKruxUc7Tbnu4D3/hD8+Hpm/mBJv8NfZWQNdXtB5Sq+gkNn1sY81ivh4ZEmMzYVMCKsL6nY11Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3ZkRsG6; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3ZkRsG6"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6facf4d8e9eso6490666d6.1
        for <mptcp@lists.linux.dev>; Thu, 10 Jul 2025 01:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752135058; x=1752739858; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOzRNnMrE09QHjUPtAsIuq7LVuq/VKKjIvcIecwwVx0=;
        b=j3ZkRsG62NA8vFZCaGQ8xOlqbh5DMIsLUy5hxNvUgc8lH7c9WTnlW8BVtix8erCEv6
         uPnt3f4THx0jio8FON5XdXhH/iMbXymttEtqY7zxQX74J6lozfuuR9nwqY+7WDMtyIcS
         xisVJRgUxQ6pVXxh8D3j7XtKtPx6Pg27r5WoiVsLNyCLvpAp1loGqPSJZNboPdC5PPaa
         6lZZI9bse0+wXdj/GcEcjhYElKYt6k7RzPjnw1dVpLWJ2Iki5KcIW3MDdlSuOgt+oOg4
         ivzJh9+W6lJpZwtpRaTiANb4Ys6oqzsAqUF483Y73sRdj/06HZ5UqF3Aa0W5hlhL+dky
         ZXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752135058; x=1752739858;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XOzRNnMrE09QHjUPtAsIuq7LVuq/VKKjIvcIecwwVx0=;
        b=BXWQAmVqwU50vomgwVvTVSQD2IUhiJls//U9na1P3n4Ccz5j61FZ3IlO1K4V16zhLB
         8GO/Dwhgb+NNU/QV22Q5OlPwtJiRc+6adPL+clwLNH2v8EDJvDZ9AXEdTO43VYbTsDdY
         PLTeDLghMO2gPwsG4QABgZdCeXfsX/zHqVL+fX7FZfypz/qfhtfdrgOHnbDk1KG3ykA9
         IsP4gSZTVnR5xyzddypBiYA0TE24xLRb1TgHO0til2WG3kaW81lNDpqNccCaZYFEy2O1
         rMXcRELxpFNI4Cy/KHXuFBOUQK5Nz46S13v0+ihtrXu+W02pZ3pvqLRjw3zV2uOz9t2j
         5nzg==
X-Gm-Message-State: AOJu0YxPdF8eGu9MQPQOqM7ulLK2Mp6LqvYVrkmveF2iv4AchG42PFIt
	mxLmx3hnqPAyhEfjYX/DmM0fcMOvPUZgzNbcN7vp0KOphURpFIRMcDNOcIC5
X-Gm-Gg: ASbGncsirRCPNl+kFUx7qNIUVlPtIC6lx9Xzhey35z2NTDYNuDx1qDI28pSyl9l881X
	4sglqJXULOsAqk5Uvk2twdrpw1XrCdjOdfKUGGz4wyntHxv9sAORpG3hS6+IxIeWOQ9HK0FK/Oy
	kpvJcub9leRIBYHIRWyJWB5vh6gFdMli6LFRZ09JlJqvZJ6x7TA/Pqu6iWIn0CJxHp1fnazcrUb
	nYXNuMBMMiXIsbH9aTJw+SW/Bwgr21fnG5/RSsL5qMWTGW50sHBSr6Go+vhl1SbB9DOq9DftBqd
	71u60jgJIBB9j6aAdMXrIqtIH3vGBBgoGViw7j3NwbnxUWrbaZZfVgLFo+jrfM2LfrqlaHFt
X-Google-Smtp-Source: AGHT+IHLIosiMRrKQanwHt80Zmi9GkrZgxuxl9/ywApV9Fi0OUZIkmWbE55f09HdjRJqdFF8hfJazg==
X-Received: by 2002:ad4:5cc4:0:b0:704:7759:4f12 with SMTP id 6a1803df08f44-704982b7c8dmr20731436d6.38.1752135057753;
        Thu, 10 Jul 2025 01:10:57 -0700 (PDT)
Received: from [127.0.0.1] ([52.162.51.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979b4968sm6319006d6.27.2025.07.10.01.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 01:10:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1752129934.git.tanggeliang@kylinos.cn>
References: <cover.1752129934.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_0/2=5D_Squash_?=
 =?UTF-8?Q?to_=22implement_mptcp_read=5Fsock=22_v8?=
Message-ID: <b2025d19-d1a5-3549-76b7-aa004cedf3f9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Jul 2025 08:10:56 +0000
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
net-next/actions/runs/16189539590

Status: failure
Initiator: Matthieu =
Baerts (NGI0)
Commits: https://github.com/multipath-tcp/mptcp_net-next/comm=
its/768ce545975a
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D980877

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
