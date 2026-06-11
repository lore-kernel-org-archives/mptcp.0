Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5F2223DEA
	for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 13:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185724; cv=none; b=kQRDZFLk8FZc8IwCTI8UE03r/99onDEoJ+zAS7EsimXKTkK37eG1HZxL7tfrnJGbRHY1lx2nliuKkCUgSM3N6rAHUXxB9TNvwG+qAYkszTUs5V2CbhFpF2vbKbnZiPJjH9KpITnsAPYlHCr0HB98ezrnurNyjCKVtkmwPRhYLvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185724; c=relaxed/simple;
	bh=KmZd3oVmSaMBejIvPKksrYt54ZjWeYwrZbakPINzZok=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=UBIBO+GLQR9P9KS4KN7hUqm9tUt+nf9+o8nbYxH00moNKKY6w/eop2vqMccPzvABRyq20pKE3cHAYZ5FjX3aSLL4llruLAFfFVM19Y+ZVwYPup98ur14TQUS8twdyU6k+vav6kOXHHer3yTVcNo5DVTvg17aXilPNytscryUNjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaeyS2uE; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaeyS2uE"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9157f7c1c0eso783399185a.1
        for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 06:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781185722; x=1781790522; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2f74wtBLguUizEzHBY7QLE4RpWEHcFnl6KkDqMyevY=;
        b=aaeyS2uEt/J0Em8+yRIxQ3ryfG4QhRWQIBpHTbDoZ8EUGhRO/sLZw11lRCXZTRVbru
         TMRYkPBH0pEY8f25cRFwzwS8kJUvoytyTPsHitF/evmbCVmBlkeY3py8GErIsFRTkazz
         sslm7y7van40Y3sUNpF+Z96OqPKzPIb7jQs8mqXZ+qC0+J0/fSpONlEDrB2xkdBS1uIS
         no6EQQXTW6ihMjNL1JEMad0g+MFi2P2m9T50xrGq0l+n3f/SEXzABpXKrf+Ty1aiN5bv
         Q1vSpQuMPqCSyuYw6If2X2OK49olPpMvp37EM5s3WcTM5EdEZXADJV5iLg+t+v6MauGu
         kw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781185722; x=1781790522;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D2f74wtBLguUizEzHBY7QLE4RpWEHcFnl6KkDqMyevY=;
        b=VFE4e56f6fng/1gPEImozYcQLro7EdTUSdmh1fiGgHIpeNHO9SZnNTHX7YXX+abufA
         cUlbR2xJ/KyvrKclZ8oxOQ9d3sAGHEQVgrYcHe6FZ7p0R+I+TZA8wQdJSBh08Lqu4lN5
         OyOk4dcooUNbhtRRkdTLg36n0RMeaFwNZ4dBcBjKJna0IE6ztu/P3Zjz/XXeeHDrrEEX
         e2QnLvZyK2GFkO9DwF5LYt8CjKLaidq/zRkEhw+kTj9qH2HPf620tvhO2wTbgErGRAWf
         xvGbG//TWyXqhzy1L1fDmNOAlFcGklaAOw8EVZMHAduVhe166xQqAeb1UQhgs7I4jaf8
         gzRA==
X-Gm-Message-State: AOJu0YzeKFBVgbv3i6DDg/VOHJD7Nyoirai4WA/XOIO40UWioLPEAsNS
	fiFJWWaItjMlejCHFovCQgacpuFiXvNbfCk0dComeQAU2YdY3kpvcI8=
X-Gm-Gg: Acq92OFuWjz+K/eND+BpT/sGSkvZtxuzGv2XcHy+Ki/71mx3m5i/94H6werbF97zE8W
	bkIDNweIpIQ3y4cCLnC0WZu+hmQosakeTb1BFFuto3jnkKGXgdCRXLybfatsJQsRb3CuTF44EW0
	C/WxJpi0lomLCSiZnBgkyxSujfVFnb10yeatVS24Lkvq6SrWGgGmf+xMFJR2yTJsuigwT6fciuY
	h7CyOqRPCsm+5zsB+Z+fJkjLK7u+EnuKyaADf1GMHrmPOk2Ikw24P0fmMdFF23KTXgk2oBjyjGN
	Xo+smV+onzfZ8jSWdQqysbNRsVTFxIxKzKCK1cgzgIehyqZK0kgwcfQ1NX8PduhQWwxPPcxmzIN
	d8fWprumGgCCg1I1ldQBmXF6jrDyQqBaoSqbEqq53av5x2jW4UhklNXVhZB4GC0iAS1DL/q/K3D
	f8Hv21jLBuSAQtkeR7a+SYtKnDxvBb5JlZ8GH7I7mU03pBJw4kOg==
X-Received: by 2002:a05:620a:1a16:b0:912:67ca:bac6 with SMTP id af79cd13be357-9160ae13418mr400198585a.26.1781185722287;
        Thu, 11 Jun 2026 06:48:42 -0700 (PDT)
Received: from [127.0.0.1] ([135.237.130.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9160acab31fsm196218185a.15.2026.06.11.06.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 06:48:41 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Wyatt Feng <bronzed_45_vested@icloud.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <81f26b8fddd59ebb6cecc417fb138d9ff5214e08.1780458440.git.bronzed_45_vested@icloud.com>
References:
 <81f26b8fddd59ebb6cecc417fb138d9ff5214e08.1780458440.git.bronzed_45_vested@icloud.com>
Subject: Re: [PATCH mptcp_net-next 1/1] mptcp: fastopen: only mark MPTFO
 subflows with SYN data
Message-ID: <946b6d30-f2fd-0b8f-e30a-3ae6d6854c14@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 13:48:41 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Wyatt,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/27351217655

Status: failure
Initiator: Matthieu =
Baerts (NGI0)
Commits: https://github.com/multipath-tcp/mptcp_net-next/comm=
its/cf5ad7ddd3d5
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1106932

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
