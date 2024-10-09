Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC47F190667
	for <mptcp@lists.linux.dev>; Wed,  9 Oct 2024 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728471565; cv=none; b=fwkMtSJ3k5zdop/VpiV+EW5SiIiIA3swtZmhJqC/vUpzLkcVTWXq83xKrNeLz6Z/cEV6d17zepbJxGb0tZNyYfCiD3lhgLJQVuxZmWiRi1YmPwJjuqg56oS+xVGfs9QVoFtJxrNQd/QtVSh9BqL5+b4mw1RSB+7z5JK0PTLaCBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728471565; c=relaxed/simple;
	bh=sXUdQjjqCH16XTv65MXmYtrHywYR7lx4llqPGXPUUjs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=YNlhQcNhdrivaMcoZIfMePHoflXKwbKiRDO5/HHTW7pFH2XxSbE8gav9coAD942rmU9XZeEGAAD713VOMCDftw9Z1VKnliKXnacZqOvU6EwtHvczo8AH4jU8LVJ98VRl6TkmEui+7McvCi/5o65HxcwGTuGmbj9XzJ4P6k58mkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfP9ElKc; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfP9ElKc"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a99e8d5df1so654786885a.2
        for <mptcp@lists.linux.dev>; Wed, 09 Oct 2024 03:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728471562; x=1729076362; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgQXjsGDWGVcMXSH/QMCpIK0wYJlqhPwWn5iqtcetIs=;
        b=GfP9ElKcNfYb7NWopHKdkei78DaIZPYAVgOgoPsKE+ezTXgSX5LDRRlOlK0/OQi7Az
         19D0hVHcMx8oTNXPv3EQVj+g3hDqHAlpA6OV6r5ZX1HH6ep/qac1y6pEDTAKFUJOzXAT
         2W3gwW3m9jA1OjsCoyOAuTNmdDEPc/sy44K/F/LVR3GxrscVKM47P7CRJLUTmJT0wKL1
         Ty5HecPe8LkU4hCrU7yzHg+1GTDD3gC+OuHOZCjcKAkQEjqeuojU+Kvl6pbOS2xgEpHA
         K+zeCahfEtt7UfZKr2YPFlKNpTWa456ZOiXL3nnMb0KYP+VkGn7N6ytqi8rSmm7i1Lfc
         WMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728471562; x=1729076362;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pgQXjsGDWGVcMXSH/QMCpIK0wYJlqhPwWn5iqtcetIs=;
        b=wj6Wb7vBKPcMpSyPRoldCTjugBUMB32VEoJmvC9HTJmkf2ZXb6AHaJyZWqgDxH1tOJ
         /5m2uXjWCNPUXI9aLUCIs2WgcoPToWHbEuwf305F+gn9UonlENSvrwdQ0k15O0HW2ol9
         JxA3MNdiuqeW2PyMNJc9GgXfMP2saj5yH6gkaAXKvsyoLCdqHW2+8XHwr9wrny5Zp0VB
         ZqOXFg7pghNkTpPrRSTTN/DacRpEl3y9grUxsSLE/x2Er0yNf+bRp+9aGy6kFvYPGBmU
         o5kXdbdjzIH9ahNmxPOjXwI5CjeehBYtktaVstSOPPmdACtrxWigG6n7x0oKb1yyUyTc
         MdGw==
X-Gm-Message-State: AOJu0Yy30RgxSid8B50ItGalF1Vi67U6rlk2QTIWxQ6nYhu8nl1gk8LI
	i840Ya0h4nTmb4sinQLEv37wBPJbswwjz4lR31rr41uYVhGTF78w1Jb5
X-Google-Smtp-Source: AGHT+IHAt4An/nsI9kjLKpaQaXFVDHkuAsMZvKK5TeJoBZjNy2lwWWe3sLgjM5lm57brS1shQKNlcw==
X-Received: by 2002:a05:620a:1987:b0:7a9:b4d2:9d70 with SMTP id af79cd13be357-7b06f967132mr335515885a.14.1728471562508;
        Wed, 09 Oct 2024 03:59:22 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.131.96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae7561e5c9sm445643585a.16.2024.10.09.03.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 03:59:22 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1728469555.git.tanggeliang@kylinos.cn>
References: <cover.1728469555.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 00/10] use bpf_iter in bpf schedulers
Message-ID: <08ea2792-07c7-5dd2-e52b-bdd3a3104fca@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Oct 2024 10:59:21 +0000
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
net-next/actions/runs/11253414700

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/a7=
7e05f49292
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D897127

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
