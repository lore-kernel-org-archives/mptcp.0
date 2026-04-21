Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77F21C5F11
	for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776786520; cv=none; b=sINx8Hs+T4uMMWXJtUMDiPiafPbWTVCOBz1k0DybZ7OrsE/OHNmF6ZUuOm8CcHkO9IsLy51vWCAux+3TTevCFkLdwcXnfGq+msRiK3fN/0SuvIqDS60Q3OnLSmDcVTEvUr9nyMb2ZXEiP+WX3lCsQ3KJCEMLVNE+tQiSuGQTHRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776786520; c=relaxed/simple;
	bh=gmtXe66dVvHwbob/VmgPTSO2D7SZnKZ16AXlzBqT0FY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=XmDdlm6T3/iAFtDswORtL34mOBBK+dmZW3mLPVIwdFxMUZ7IC068lSIHKtJ6JH0hKFvqsjnpr4FGLBbGtw2dMO23fPEPgNgQnsVW9bJF1mW4BZpQL18kABkKKvazZvnTbIK6AnqdAb+ds57dHcieiOK8KgHFalBpaudW27bFNig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mdj/TOV/; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mdj/TOV/"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12c8c9c4cd8so1108033c88.0
        for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 08:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776786519; x=1777391319; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X63yjZ8H3mV1qiV6gj51ZJZ2CZ1mZCYqxiOUjn+Qu+8=;
        b=Mdj/TOV/XN9RU79zm5mJPL01WiHUmVJalMmAHLl9wwysD/fZBDoG2zasXBMX+9IfzM
         MffUIp6c/ZrzFC9HmZCMpdOlAvfCG7R1/HbfuoHinZnBb2DGwHCGBGVTXNj1Ydf2b0O0
         RpwtHq45mFelWxgmdFQanFBkNkftHheGMZGHhtJZnCa/bIgFTHO/gAJMjrzgc4Rlt74X
         J+k+2u0zPYQ63uRzJYhIuqpu08QmVaYijq7Aowd2PJzx2C88KwNbfjw/HRy07MVij1Ds
         pX5a8BFmuvB7GEhPPg2PPZB6GpJGrpPr331n6FA/K5BPiL3ildPo8JeRt1QJWV0OT8v2
         8rrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776786519; x=1777391319;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X63yjZ8H3mV1qiV6gj51ZJZ2CZ1mZCYqxiOUjn+Qu+8=;
        b=U8UPlycaqTF1K10ybmd3ISU8ndRITi7/mK0Belpy5ZJ9zAOZ2C3ziszYI9WoYhRbjk
         I4lp11wLE1kY2jDblHQpz+H+DXlwF4VolRpgDo1ULrwk3VlnZm/XJOx/ysoX7NoSvamF
         B/vminxQxW4xU9lIb/Qc8tjwfREEjmj6CJ2r8E46eyND9I/N33XZKhlxgQpAe88Cuwwj
         LETa8mqEVGcXXb23N9CDeErJwug0WNpLFae2F9KxXvWA/yyjeLwGtfl/J/BrkmYMIJqv
         oPd9dZx2OSYrtgiLGGKSaPFae25ODosYT2QieV5UrxYzXTM2EMNMPvKPzx2veNQMMYTF
         FmUA==
X-Gm-Message-State: AOJu0YysMfwLlnkmyDNDKuB13kx8ju7ZgIyWkDGBpp+CkwSL++XV8b1P
	kWujPfhjFNZ66enR7SLbkEwNrJPHUtNzOMPO4ZJ8fkpGedN1rbhGJgo=
X-Gm-Gg: AeBDiesFAuBJ79M714DKsR6VNgphOIWBS1cly9ZXOghzCi93JsmVbn5fWl5F9H5g4NU
	jtvgY/duPmte58ofQyVbDl7/8jCmkUdJGbMxPRK+eWDyX89SXv1gpp1YcpIKNfj8TUUc+wWaLZn
	NrqHdd1QrurxG/q/TL+AwTOE+Ec4iG8iPENlOUu+gZYMKNo6fagGQVS2n8tcviepiFou4ThHOAW
	isyQ/kZg81fKZ6z1ScUHJ8ErmJ8CfXDuGMbRtxIrfmHWZvsGJUoqdIpAp977wg0YaF6X25KG0qW
	K+SWkyA3Vjh2Biji6q6szu1YpMufd+FCmAnx5YJ0RPE3nZKNhPcbx1gcmcJq/zvjoDUnjC7W7c1
	pHwf4E/D0yfY9PGztK3Acgwf6SQBvJq5mowLU3MVW9t8DhSsxi0Mq1JcSXx4Wa+oi7D2ikEsbxz
	IK3HhY/ygD/CRoQA027enD8wUthBqVLFeIL/S6S5HCnVo9lbRkVkMorVFuaA==
X-Received: by 2002:a05:7023:b0d:b0:12a:6d05:3938 with SMTP id a92af1059eb24-12c73afc31fmr6622583c88.7.1776786518815;
        Tue, 21 Apr 2026 08:48:38 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.76.211])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12db8684f90sm313461c88.13.2026.04.21.08.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 08:48:38 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260421152216.38127-1-devnexen@gmail.com>
References: <20260421152216.38127-1-devnexen@gmail.com>
Subject: Re: [PATCH 0/3] mptcp: add RECVERR and MSG_ERRQUEUE support
Message-ID: <4d97ea72-1ab1-b037-e434-5a32b60ac867@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 15:48:37 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi David,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/24731734238

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/5d=
c9123ab172
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1083918

Feel free to reply to this email if you cannot access =
logs, if you need
some support to fix the error, if this doesn't seem to be=
 caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
