Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904A73446DE
	for <mptcp@lists.linux.dev>; Fri, 24 Jul 2026 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784879613; cv=none; b=Dsft50BGPPsj/nZWIzab/FV1R+ZHmBguP1mrP9v1No0HlIP7r+f07r7T/76VyBeT8TaujOjUccnDP/jCtiVT82kz9z9ChBIJRT25vbDNKO8K17GQa/AKtUyrPwsR6hYo8CQr+sCYkuuSIUAEd0d4xFXEhgwDqCsZFkafqKgrMzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784879613; c=relaxed/simple;
	bh=9bOiUXhE/1kt319v6OorhBYrgYIwQArUqtaOzx6Z75o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=ZOv+U9FuTyc7lcypyJO3elStdCOMIkkM/LC7asK5KTqtf3C1uDTd9qTk2OXzALxFzK55mpaVLZMEQb8ihnrU3Rz0NScucrpjuLAdNj2HAeewdFCT9HweK/9V0Ut0WwEb8BMfyV6ZFL7IQuJTj87vzM9DWDSewXyGQAlPGd6FoFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgMDEDhY; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgMDEDhY"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c981c2c37cbso128920a12.0
        for <mptcp@lists.linux.dev>; Fri, 24 Jul 2026 00:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784879612; x=1785484412; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GdLI0i/xbDg/Eq+ALQTWLSYjyX/BRR/2kG+dzxoud/c=;
        b=DgMDEDhYkUii+YQlMWLUoFDBVsVS3+4ZswernNZ8UrgrdYeg+1OEP6f7Um3mcWUKNw
         KAA6N6uhoulwcKmcXaENmZrHi2DCOGSLQf1xj5rqnOGQ5u4IpjTBQ16zIIo6AQLFHFnJ
         yG1LiJ6xOWGJVELBuN2RtsrmxmLkip/O87SQwVTbihpDmA3aNQn9tzVtP6Wgkk/JkOIg
         rRBkiBA1v4MkxuyTEQVexWfVVN8Zl60l9VctFTICy6eqyLoJ9VFLtbFznHCg2VAKokkw
         KlIu4echiHOQSk97Cr0+7mOia5bj6xtf7NhtUljCYlnQGWgNsQreu7Opfq6PTBVEdibz
         SdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784879612; x=1785484412;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GdLI0i/xbDg/Eq+ALQTWLSYjyX/BRR/2kG+dzxoud/c=;
        b=lRcU1/UUEBZJ+aMzEuEK3bmUX+uh01z0eGVIj/q/gTsS0l1ZLgl7a1pyVRK3OyV3pk
         k4H4IPr3FcoHe2Fuq/RezJzrp61Rvl7bOpTnD45Go+LxfdfpxJWvu8FDn/J7VBB5HKy6
         gC5A/shbIXwZavXRRhtfqNAjLrEhtdYaNAsw1A97sMctldXqa8oqWBOTB2IJZ9dnaF+q
         o3C1EkC2RGtGNMVduMSt8qesj2RJ4zij7ndRICpg01yghnXC9IEkvrqmYDpKT5wdMWSl
         LaxJNvgSqeK6/HH4eXBpFOUX1j/ak5Mo8XGle/qvV3ykZwnjoESLS+n5pcEcrsytOMA8
         bq4w==
X-Gm-Message-State: AOJu0YzTa5nGHzH6At7Kqaab4N6VHmSwvq4F4RmCscW/WfoCkuCSFg57
	+AT9Id0nQdVBpLoiV5V8ai2U9nfgZgJKV/5hKHGP9ThKzSgw6GPCGh6hhfQPjkw=
X-Gm-Gg: AR+sD10kW9bLX5VCU+JobqC4hTXLY/2v0Ms9LBh+5/GxAYbZr1FVbZ7AmUI0zr9GeKp
	6qX4mcDLNq++sgJnf7C8Yb0e6fMZmHCNTltCDGPKwCD3yQY9lT5L1vBnuC1349qkyNUh9sx28Ge
	XwdbfZTE3dx4Bu114TpMUsPb7bug4rGP0zetyS7mzK0SoR2D8hEDkMH6g5kakXc6EOWR4hzAF8O
	a7igPkfraugGrw7fWyQ6C+v3vV+i25gkLQYYvPfT8t4LY8xdq6a6uOb4x1mQK90J3fGduthmyjp
	YRB1nNTK7SiHj7/+jkCMRFj1p5f3xyoNaa4YtQOClLig0/jk1lnzXrIZYgvWyWhuNiNX47gDlO2
	K/+NRcDIkwOPHYftMcwKrwbi0ufC8vZiO272YkdKwwWlilRCQMoKriPRaQ5/gGPtaraLhq11+eI
	csxr+vmoZUX/rRDq7clKN2L5ydZ8Q=
X-Received: by 2002:a05:6a21:6e84:b0:3bf:b60b:da95 with SMTP id adf61e73a8af0-3c44b21176cmr7112553637.60.1784879611859;
        Fri, 24 Jul 2026 00:53:31 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.254.70])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f0d7acfsm3911741a12.3.2026.07.24.00.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 00:53:30 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260724065229.36736-1-gang.yan@linux.dev>
References: <20260724065229.36736-1-gang.yan@linux.dev>
Subject: Re: [PATCH mptcp-next 0/2] selftests: mptcp: some improvement for
 selftests
Message-ID: <b0833f47-df66-3df3-5baa-d10a65e7a2c4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 07:53:30 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/300745=
99252

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1a463b49605d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1133691


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
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
