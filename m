Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AC11B85E2
	for <mptcp@lists.linux.dev>; Thu, 24 Oct 2024 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767206; cv=none; b=JzLaZxyODyvnFN5/Oedms/UFg1n7Xcsd/GAxkD+fBZ9jpPutoHdMijtvcCD2W4VAgvWOGPR7smic4Ef0Pm/eJmOMiOSoeOolGUSZCg1L1HWhW6iNYWXdH1Mlh1MNFED9q36g+ZLvllXtRMSXvbughxnhzUvYwTSQJ3CH2S7kneg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767206; c=relaxed/simple;
	bh=y/3mHrCz0CTfe6t0HAyM07YYvz0QqG9yEx9WzoVzANk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=IJif+S3J+2oRfyby0pUfH4CsofYBLd65bLZgppZzShR+DgT/kP1T2UsD9NMxTHWKZvcEout06dhNwpixgr5wp3B8xvwjOWDkft68FhvCmAuAqjWV1IIvaeymVBP8yPa7GyYaeQStGbYbUA30Rn0WFr6bduCPozIC7RrDQhcSi24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDO857OH; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDO857OH"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6cbe3e99680so4412936d6.3
        for <mptcp@lists.linux.dev>; Thu, 24 Oct 2024 03:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729767203; x=1730372003; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTc4dRA4sjNIgtE6KP+SeSeTPOpXP7wOVNmwIcYCIPA=;
        b=eDO857OHoHubZipOhpLE8kFkf9oV5YjWfJ/jgu+BBxiMgY78Jl4QxG6+piToaQO7EM
         4LZOo/ZkpsOQq+BdD6UfAb1DHiJoqqZjSM8U4WjkECtJcD7fDjLYpMzGcPkXEbM1MM5Y
         F0PkHIq0MWJRxay6wSBM1O13WISOWVobdIp4rYLIhV89VuYSezBqtRrMQ67P6OfolVjO
         F+1QU8GSZkt39iw6vL2S/obN3DEREDWyyDs0Qjfk2zpwtNDO8IyZhsre06QAdPVovzAd
         a/dmD3C9A6392if6e6CKK1OD28Kh0Tuit+3B1FJUJYb92CL2oCI2wdjZn8RRA/zjoohh
         UCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729767203; x=1730372003;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pTc4dRA4sjNIgtE6KP+SeSeTPOpXP7wOVNmwIcYCIPA=;
        b=g35ZkE2AxPOygFsnjeAt6x4Wmc+JuS/OwfSt97Gb7Z5hcf0pIrQ0wtv0/0tlHJDgGp
         cmriwyzUqDpH3wDw3naMuV053OXrWTYuHK5U7S8CL0bU0bmFox74Bz9s+vGVQnSTlS8x
         fkcmCZKYGbSSem+bOg2oqbb94z/bYDXwARPWLxSJHasHl21bO2CKjTPqlIbv/BDSdVNd
         vX4+FNqmuN/zna59vZTYAOxLy/Zo4ZUxWiYoIyELJ/K1xpLqaqdEzSH+uWH1ikKjjelS
         rLpHKlq8nqaSUc7ohT0NrFaSnnDjhYGDuW7yXekG2XTiqgMrXo0pm7RwMmlpySjkmoVs
         VTZA==
X-Gm-Message-State: AOJu0YxshlEXnbCGTcz6a3Pv9f4hz4EDxrdhwUdSuGqLGAhJ4HBXcBcR
	G/34ybKE9K892puyqm1iotSv9VuEs+gOWqrD2Sg7MnILhDQN5IFe/jSO
X-Google-Smtp-Source: AGHT+IHx5hAWByQQlU9oNxVmYF5HNFX67kd30oJFXqkjwAHO+gU5ZF4H+t7SCN1w6VPqOG8brlFqew==
X-Received: by 2002:a05:6214:45a1:b0:6c5:8a85:19fe with SMTP id 6a1803df08f44-6d099c111e5mr13413656d6.51.1729767202874;
        Thu, 24 Oct 2024 03:53:22 -0700 (PDT)
Received: from [127.0.0.1] ([40.79.247.236])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce009e6653sm48450846d6.130.2024.10.24.03.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 03:53:22 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1729765157.git.tanggeliang@kylinos.cn>
References: <cover.1729765157.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v2_0/3=5D_Fixe?=
 =?UTF-8?Q?s_for_=22use_bpf=5Fiter_in_bpf_scheduler?= =?UTF-8?Q?s=22_v8?=
Message-ID: <d4576c20-ed3e-168a-3717-936daa371e75@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Oct 2024 10:53:21 +0000
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
net-next/actions/runs/11497633619

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/34=
d3a58b0bfa
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D902633

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
