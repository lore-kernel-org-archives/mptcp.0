Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B3412FF8E
	for <mptcp@lists.linux.dev>; Thu,  9 May 2024 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715254780; cv=none; b=POq078hRZpHqZBttWZ76UaD5oSC1GQX0flo6nWgc49J0r04LRNokB6G0D2oKKN9j6sTt7b2YVS2Y9BWOB6UKojmFOo2mJADfg/qVnf7ibfXDYx4Sp0LQTTVb+uhiOsYF1o43AaIAlFOH+d8+YVJgWPNnN0ggSbyZmJfx5ZPh428=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715254780; c=relaxed/simple;
	bh=Kug4QWMPiuA2WRvbw0WZFXxXYrrJBvhq52RgDR1Msrw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=XeYlA9/cZAMRyl1wGSzZZlTmxSp/QVfRsWzQrofKMYxa53dG25D2F2lVuIMPjcAz3zkWhShrS8Astjzjcc6BZjHjqxJlFkoZADbDVj6yXZX4kV7ENreMSftQCMk0w9fCh8OWuP49Ru0g3UpLuQBai67LidfA1186qDO/Iy9spSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVP0Bcb4; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVP0Bcb4"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-de604ca3cfcso759732276.3
        for <mptcp@lists.linux.dev>; Thu, 09 May 2024 04:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715254778; x=1715859578; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYMGUmFK4LQuwW33uzOS6ah7/AY6d/c4VRZqnU42uSQ=;
        b=mVP0Bcb4aXIEZ9kcNS8Tjd3G1MBT5AQw6xFeZc68n23sOiCCLHrPe9Hc8LpuoAIDsw
         t8ytf7kXNL9QgcnzD7zUFK3DwX8bjYzFGct/PUusRJBSbNXKgWuN+INGkHI4qUrYRq76
         06MaCnyIws7AVIzteouTRezN/s66qGIZf4rBYIjkcASt5Y5mQHO3t8ddLQDO6LkW+LXI
         N2NhiU1v4LVdAbJwU///OJI72ZJTXvDXQOcoXk9J24z0o2x2JCLTwRh3k8ILHqT6E5LA
         OnNQA0Y/jI5oXMpWDc1WGlF8rZRIFk72ArFX13z/k8zJ81A/PIOrbqz8EcgwRlMOcyNT
         /Dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715254778; x=1715859578;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZYMGUmFK4LQuwW33uzOS6ah7/AY6d/c4VRZqnU42uSQ=;
        b=kyAyi5velKidhMHc6O33ZF2bItnOOEd6kp/GYOg/VM7+hRo6w84XeRUuiNgUctbG/r
         4l8b3wXJ5JE98KqwcJxcq3hHMrO9i4OYgg8psOoE+WpADRXlFvYuQwHI5gizrJuJFznQ
         dv3R7vHlcpFgKHyfzK1IwiEIjsyUtnoPoxayRelDPj3qlF3eaFV0dggEizNxcgz98Bw7
         gxwACAF5zoUF5xelL4IrBF5lpYk5qZmncc86nkLFUBlRzY1h+vP3MAMmRilqzYj0MnXj
         DCZWACfp/B1Q6QRox4/JSwC6GNWxE2donvr6rWrf+BGE5Kcv5nPiK3gi0q4jdML4bfft
         bxRg==
X-Gm-Message-State: AOJu0Yz99pDq28AOXwBpJARSaEWwLGvA33AbBKUpQANSY2ydD5Y+5AjA
	bxg0hMXs2AL/EYgQF3hPNMozGMYAUsUG6bh24+7v19DOqnf3KDc=
X-Google-Smtp-Source: AGHT+IFZqcZdDOfZXbwIk9AA+p0X8e452ennpmRJoSR2v7DjIfTUa+jNNs8Lbtg5oAzvvdQkiNV5Aw==
X-Received: by 2002:a5b:549:0:b0:de6:e4d:e990 with SMTP id 3f1490d57ef6-debb9d3d708mr4706054276.37.1715254777972;
        Thu, 09 May 2024 04:39:37 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.107.213])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-debd372ab16sm264368276.21.2024.05.09.04.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 04:39:37 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240509-mptcp-tcp-keepalive-sockopts-v2-0-5f97067847a2@kernel.org>
References:
 <20240509-mptcp-tcp-keepalive-sockopts-v2-0-5f97067847a2@kernel.org>
Subject: Re: [PATCH mptcp-net v2 0/2] mptcp: getsockopt(SO_KEEPALIVE) and
 TCP_KEEP* sockopts
Message-ID: <9f143b91-b897-b23a-a869-080841b228e5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 May 2024 11:39:36 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/9016301142

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7df5fa34e3e5
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D851859


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
