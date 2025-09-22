Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0EA27E06C
	for <mptcp@lists.linux.dev>; Mon, 22 Sep 2025 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530844; cv=none; b=bKVgJfxJd4veE4QESiLP17frQ+u5IqtLZ4YGi1edkx6NpQSLdkdH3WBIYhPQTYIMl5VmVBsZeuBgju5g61f+Qwapp51+b8HxBT92LlF9QzjdIRQ4zlV9q6xdD1Cy/y3FkhM5iOU3rV9MBrz6+HwdHxcYbATDd/VHbGoAuet0/Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530844; c=relaxed/simple;
	bh=FRmizhle467RjpQsf7DBpOcN8zWIIshqLNoqjr9qQQA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=WKV/16Wmg32EqX0050zzrQYI1kh7fIpcTKFDX/HbECL/NjwFyuu+wnEC/dNozrXVtZoDnm142rMowwKgwI08Bd03+HK5N9UEgF1h1gKRzLRXumerAzNMfB9TqISyrumAqVrrNtH2cJTImUjmQZhoRdzOlRTv18TuMK/cbFusk6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUL0JRnT; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUL0JRnT"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32e715cbad3so4354797a91.3
        for <mptcp@lists.linux.dev>; Mon, 22 Sep 2025 01:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758530842; x=1759135642; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o62mbSeHJOT8faFo6Uva1BCkhDQC+4xqtJsw7vqv5gY=;
        b=OUL0JRnTB7Au3mOBW9l6XoX9i4yRM4E1FeSlXM4S7a2pTCwNeU6EtucwaRB811HKPB
         b8VuvEenyk0YFQ1jBbBrZ8kIRrL6BQMSOYdZtQQWLn30LhMveX/MWZ6Z/vrdW+ccjy4B
         bgSPV2wlFlMS+EDwtXFl2nxIJdOaU2qdAMONFOQ8X8NEc9AbMHBnYtKFE5Kai86/dlYz
         Y96cEbBahjVk2PDejLAGvuF6+S8p+9LpNeatHSD1OugW9fB3Nn3I8CL2Z4mcbWnQvW+B
         75RD1qzYvunSAifY/+UPLaxVXzuLdI6lSgjZEbeqKuABpMH8p1GUtTYjyEm37dvQcS9U
         pXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758530842; x=1759135642;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o62mbSeHJOT8faFo6Uva1BCkhDQC+4xqtJsw7vqv5gY=;
        b=Zz4s0KZ6lJRo3CKNX2yQihVRrYe634TqSqGSraPNusruFyFz0uzBMf8Sw+K3y1t0+e
         8aDndwAaQ1gpL5n1wokvpdgTvbBl+4J1mairPopZ5fof8yzCasDMFcsognrYf7y8GfIy
         zqXCZKYTDZQ8IV+//wKMbmjy5OW48Iu/YIFY8Z709Aozva+L+yzmV9zDjEiyDlbP5UfC
         pkWhpZxoRMgeZTRZEUoT8NrTvIGBE3IsWMSQ8xG7A4sDnM1UhMO2mbiLbzQfL//TD3x2
         KWCwxBvWYyi5LP5G93BTF+xBf9Izf2sOMCNstiot8Ew/y9bpbtCE/oFbL7WxvxMVuUw9
         OpQQ==
X-Gm-Message-State: AOJu0Yw3wfB8pgy58Zmuh5KDNPVqfFZoP5e4LNuA54KIkeqSpfb7Yt4+
	3Cu9PMyQKSlnp/aJCQd513kFlEpe66pnEE86zZ/cQy+sWAL+pYwjoL2ZTQZk
X-Gm-Gg: ASbGncsmsrjLCfokOxnRhqD1mkjxFMH1P/wf0RNbcgPCBthEQxEJTRbSH5bRmuKbBw4
	rs8LoWxpwYe+ibQUFWWv/wZmpnCQln5M7pI1uarFJwNiEcoGeHuYhA2bgMvwl1cmPMSJFuuTWlo
	eP7guDDQfaDm+EwVLIQfuuGK8byyPV6XwM27urPJbfrRQeRs9HShR5Dbi+Q25iaHhCykV2ehDVz
	aLxNw4LM2VAYxxjkqmHrutuzyGHSRapEfCkPHXHkGnrIZca3NU5Ty2d3UU+NR40FX8Fb7TAIXem
	8YUavfWz7O5znTyr0/GXHOvbJd3rld8a2Z+q+NNuBeOvHOvNuYiPktMXjTLJY/7mVzSLIAn3Enp
	T8O5XaME4LUkp+qflQvkqFQt6jkjFCQPLvyU=
X-Google-Smtp-Source: AGHT+IFoarBLz1T8vzczfWa/6QJR+S5N7ewYAabaD7FU4wgMnX15f1BrMT7CA/W/suGeR3kk770haQ==
X-Received: by 2002:a17:90b:5185:b0:330:a454:c31a with SMTP id 98e67ed59e1d1-330a454c3eamr11509268a91.32.1758530842404;
        Mon, 22 Sep 2025 01:47:22 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.61.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33047220cfesm8158071a91.2.2025.09.22.01.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 01:47:21 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1758339666.git.tanggeliang@kylinos.cn>
References: <cover.1758339666.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_0/2=5D_fixes_f?=
 =?UTF-8?Q?or_=22mptcp=3A_receive_path_improvement?= =?UTF-8?Q?=22_v3?=
Message-ID: <37371bd2-3cd7-dc0e-a610-603f96db2ab8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Sep 2025 08:47:21 +0000
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
net-next/actions/runs/17909424670

Status: failure
Initiator: Matthieu =
Baerts (NGI0)
Commits: https://github.com/multipath-tcp/mptcp_net-next/comm=
its/808fa7e15d01
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1004452

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
