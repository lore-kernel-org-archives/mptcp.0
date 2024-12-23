Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71AC259489
	for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734945674; cv=none; b=YapCHP1gO0EOLpRV8dgaeG5xwQ70RB9scWw88LMeCJVpQ9Hck1PpRxyIB8fq7Y1gf7JLdzBp6srC0YGNbQb773LRUsX2ixoXHO6Uh9kjMea6Zw5F+Kz2/vH5RYhQct4J22tL8ZtlTICB1buvzCp4irE5LOvTEszK0+Ar6DWFhdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734945674; c=relaxed/simple;
	bh=Bp5os6rR7pSwyZUINDJlwr62GuLYyKbv081Y96E6pbo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=pNedjPpfoDLfFnAR9DaTbKcY933oHbFopKiLb6CWj2xF9/JB/ylWOt7/qtKDUbZdr5G7N+r5fWqbXnBNqe+xjjj5aXdeqBNBZNuNmXlttl8Sv2G0Xi/fIGuOuiu9sgALi8L65xqtMIMPaCTXH0VsbMcKe35Dqc8rV8StjHIAnVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkNMUJsL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkNMUJsL"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-216634dd574so25892735ad.2
        for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 01:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734945672; x=1735550472; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/052N/SrAwVq1XyruAYC2cIJtTqVL9NlV9fbb30cw/c=;
        b=RkNMUJsLw96khwAhFzeT3odDOlylQaW7xtH/MbVI0HhL42Dwmm+WgoeDtuZrIL8IZQ
         gkiufQB/FSDtWc6ZwAVPDlOrvgv2Mce6CoIKLMHfIaFO1wKpLDHMK0FKRsLX6zxqeV2g
         NL9Sks2boFIHGfLhfo02yPOS748ZAuEa21ddGYXgAUfxbRXFMDPT/RL/wmXlHPzqcxKW
         XuA2Tqzkr5AeMr/0EvMC9S4SM9fXc2gLCSt8/wePF/D/WU7Kno5jcpewfp94E7xK+H/v
         JW2q1VtfIE1RxROeMLQbF7LU3QeurtNqZJyWeSQYCPmsCoPuDwtQyvtKMj9EwOC/RcPI
         HAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734945672; x=1735550472;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/052N/SrAwVq1XyruAYC2cIJtTqVL9NlV9fbb30cw/c=;
        b=PohmofZS0c2TZho55nfgThSCtRrxDui2vtSucAjNyTxmEzascSjg2kwipZnGpGugoc
         zgl58JEObPzhYUphZGz/eZbiQN2asWbmCxZBIacXGIukdJlhm4q18ovpoQOS5M7Ov/6i
         KpF18RLEkmkaD9Z19fHngwTNaer1PLJ5cPi3DM7LppLazwVUuMy6eqo1k/mUoGQEXa+R
         pPlZuTkyBO55GvMBvPvacJmjPo3cBF1dVgGut9HXoB9g2aQ8a6nx5D1nINxsYmOaQKmL
         B07afVYXoGjFtTClnq4ZRoujrgXFT/Q/hoskK+d0ljqN5Euq+rJZOvZAa4jR2Vqiz96G
         +5vA==
X-Gm-Message-State: AOJu0Yzw92RMTofMCPTJzGkktZOWYbrA4b0U7PXj7HXgltZHglqPeOVe
	4SUdGo1zySqLwJHQ6SlcBZv6WB6DbHgk+IoErsIVgjhqymAVwC9PIsYx
X-Gm-Gg: ASbGncvMyBZRo7ug65ZxURvHp+skEZAWL/jnNrEZwt4IOw7m8xRKclsEO4Dincl3yp5
	rjuwKRfiKxiutTSonDAhC8yTeaeS9Tj6X3guAWnjKraVDJkpCmIwd/MTZWz9EWDL9IUGAWlzKpZ
	IGDx1Frwde1e5TW7rDpN66KkxVaX2IEvRUU9CpqGbI7xDOWJIw9B0EiNvk2fe3DmsZRrHcn43qs
	KpCFpXoezJulCCC/FdFH8aCw5hS+Tjmp5XXYe3WDnyR04XYePetB4Hm/X8QIKeaV14=
X-Google-Smtp-Source: AGHT+IEv3ZMnLFsIcI78OIT4ANpynOGH+yVjhJzcaSHYeiOneLEpfAm1yonLCK599PR9gL3g0GJt8A==
X-Received: by 2002:a17:902:db0f:b0:215:3849:9275 with SMTP id d9443c01a7336-219e6f2831emr192237195ad.49.1734945671806;
        Mon, 23 Dec 2024 01:21:11 -0800 (PST)
Received: from [127.0.0.1] ([13.91.68.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96ebabsm69175095ad.84.2024.12.23.01.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:21:11 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1734942318.git.tanggeliang@kylinos.cn>
References: <cover.1734942318.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/9] split get_subflow interface into two
Message-ID: <8e9b43a4-85a1-5f34-9f55-f30554b166c9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Dec 2024 09:21:10 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/12463812845

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/cc75b61e9055
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D920351


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
