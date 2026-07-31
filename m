Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7513CCFBD
	for <mptcp@lists.linux.dev>; Fri, 31 Jul 2026 10:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785492462; cv=none; b=ofIpx9vJJgU+BgfwHkxI0o9Vcpc4PKNweVxYzTRAvnk/QMeKgoFu3Ruxs7FIGDgKTOBLgVynLOP3AkgkpSfmi8iRjMimCDB6lIiB21VCn5dXHyO04ThvEw9xZfDRUHJOde21ax77svj5TKn4XGPgQg/v0B7mwNpdtodFMkTvcJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785492462; c=relaxed/simple;
	bh=3Cj1wOH2DAQ7ScEDmE8CtWW8jGmSvIimjJsTCSmmkWQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Ave1Wmj/bLhwxMZk1UZ5h4wydx1/zhUo+d5JVlgcwp4rZ3jCFH/sAFI6s/YltdVe3/zNDSNcQBQSufub1rLLX2VWGVtR21ccpRmJFHK9mcQUakfdVT00l5WYR1OUVKXO6ZvsgWoUOUJW51ivEaDiFLcdjNufF3B3Bc4kA7eaHeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtFYm5UD; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtFYm5UD"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6acc74fee76so319995eaf.3
        for <mptcp@lists.linux.dev>; Fri, 31 Jul 2026 03:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785492443; x=1786097243; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6qoFUPhtnt6SHRM6xlwTZJ9BzPd3jJDgYO6QVbOFomY=;
        b=BtFYm5UDGLCzdqu8kOVmirvHkY9JT5YmF3sFzfUAKT8mAlt0WqI//ZkRd56++NckG5
         HZ04P75nRl4T0DAiYK8xe+XgfyT8jfHbYu69i6Q3spbsuIseaa4dkVci/hPJQKUfjWzt
         BrldKdlWJns8iC4uTJRmf+Dx5ly3OCYj5auHe9JkzwWw2RJ0HH353t7NcfzPCaQ/+pue
         MEoq+pkoDmonjLKibFZ5AaN2+BSw1QGWgu72/rgH9G9CH9MQK/Lzj3Rc/DknL4oJ12uQ
         SqqvSQ8L5OPBb4hj1uFb1iBQU0KuBL7c8EsbC1CbY7eF60Q4naRRL4DmqceQ5qhdkE0c
         kfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785492443; x=1786097243;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6qoFUPhtnt6SHRM6xlwTZJ9BzPd3jJDgYO6QVbOFomY=;
        b=YXDn3vIpLr8KJOe8bdQOUQqXvU1wlDnmXy86N4BNLIKsZm9iesWLlv1XnwPMWNIT1L
         MLV24J8zHMmMx6wSCZzsvsJmW31bTf78Hfv4/QFz5ZjOLsMT9lIBGnTMdTAF+HS22P6A
         FOu1wM+jhGtBpK/x/LBgmiF7UBZ17iQSvdURj1ThWcprFUifs9cPlZxebu4uXz870Cci
         LtYdHMCVkyQ6qDlhmlunrrRubTE/u76hct+E/Tp8AINiImeCdHeKuSTGioasEdpGP+Km
         EBYihbmUxcrxBgd1T0xl/qSgP9rqUdo6UBpKBjQAH0AUMR2Xdg+9AWTzqhoviic0qX/F
         90MA==
X-Gm-Message-State: AOJu0YzhkLXrVorayFVRdajLPMudzGBqtJkLZa7Nm3Hx+Zppy7WEFd4C
	3ENXHTmWS7q6SNAYBt0IrxFRHYq4BlQHzHKROREc4DlI1w7c1+3eSWCKjLx76OY=
X-Gm-Gg: AR+sD12OnXjbtbnNPI0vnFYDYrj//4zmLwN/T3NNLi5fgfNADRF0hnqBf4PtFmc+ggh
	rIMrwTWNmDanZP3lr6MqzkUDIge9MgDyQD0WaY0sRTRttj53advKRpp1+6fYY+3w+iSGx+cj7/n
	jUdSM5xlJiW+BTHnOas7A2XAuJn9og9tZsxGJ4wfDL+gkKoMe3KhnrLKG5TIJJwbPSMJLJFIwYB
	eFtt4gv/zgC7pBDLFI+DN8MdFFwxfgii7+rxxN/m8VGhTLmNvQcFLLW1rwN8Vbcs+2XVzz+XMrJ
	5e48Wntbdgpf+ZyQe6LiX4v/KaJh26mwjt/9DB1ILbF+D0e1RD6UzNsJnKPE4O8qUughX9Ruztm
	5gTQ8v4PmK9sdtwmOlSJoz3hxs08lSzKWSny4nydDQf3qxPPKzaJO5id3aWWstCDxvorLxhfdsj
	/d4+ldVNXO8H2gwtDgRf3qMIgAzvewt3AtPUL1FjZBFRTdPrurfsuTK5usq8ko9I2CZvWOcyQsD
	CU=
X-Received: by 2002:a05:6820:80b:b0:6ac:b80e:76b0 with SMTP id 006d021491bc7-6ae37d88314mr1017288eaf.3.1785492442704;
        Fri, 31 Jul 2026 03:07:22 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.130.212])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae3a0c9162sm603304eaf.11.2026.07.31.03.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 03:07:21 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260731-mptcp-squash-ooo-pruning-v1-0-a5f5115e1e24@kernel.org>
References:
 <20260731-mptcp-squash-ooo-pruning-v1-0-a5f5115e1e24@kernel.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_0/2=5D_Squash_?=
 =?UTF-8?Q?to_=22mptcp=3A_out-of-order_queue_prunin?= =?UTF-8?Q?g=22?=
Message-ID: <b04f3574-2431-538b-9dfd-53becf4111cf@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 10:07:20 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/30621520151

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/ca=
0afcf3d680
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1138022

Feel free to reply to this email if you cannot access =
logs, if you need
some support to fix the error, if this doesn't seem to be=
 caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
