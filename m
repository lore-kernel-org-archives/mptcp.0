Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB349408013
	for <mptcp@lists.linux.dev>; Mon, 29 Jun 2026 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739318; cv=none; b=l8v09Cdlu1utxDIa5VCS68l3hqOtBTWl8YNHyrwTKTWfvhokI8nLzLZ3tODouYFyGdpTP0Mm5NMUbDUL9vFdRISYt0Ep9UD65hlZ9syditBU7Qg6mncihEzJrPC9VZW+KIE99ssYVnGtnR8NxxD574ng/+6eljWl6utoR7vNTXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739318; c=relaxed/simple;
	bh=+9/duErGR3l4f1+E4MIGWtRfoZBwU0xCATK5obOx9dc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=IfrJd4tnknVGHGk5ucNNTK0k/3SFlMVyCDyjGyjFsGDTfL9DX+Ne+GVyJONR8T2fh5q1CWFafUfrqTjFFrSUmaqv+pmt+NVAv+lqARilcOlj1Aojw1eLXYF/zmRndoYYESmD1om7FQYGWCabwW/e9PkhhFskWGYIjZCeXJaWch8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NovN9uel; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NovN9uel"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c7cfa17fedso28268505ad.3
        for <mptcp@lists.linux.dev>; Mon, 29 Jun 2026 06:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782739317; x=1783344117; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TSC9CtHgYqUCOdK3+VzK/5HXq0/GHLurgoMPfqp2XI=;
        b=NovN9uelxUT1qLwsVe85sJhj5ufGNFN5mf2/ZiPBO9T6PIuy/eh3K35U2oIabOGDxD
         zfDn/5Wk0nacrPsW5VoYoLNPL7Ksj7EoAjiQFP9BZ0IqVzBzH6nWoFWOS22iyHAC1Ws8
         /WVuiJGzkdvObSV5MKUCCVBOTfEVXsBhoVvWAPobNG0As6QiRQtxdHu0WjnaDqq8FWkU
         RPAkEYBegRXjNnq9W70mvc+Jb4WqvmrohOwMDFuvGIar5wprsCP616Ipt/RaKGWi/nKH
         7QY4t13pdCrPbPQ59DlzK7xkyT9WsW3V6wwQ4DJjw/feCQ6SM9QsoBMPqfPp7ya8v3Ff
         yuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782739317; x=1783344117;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9TSC9CtHgYqUCOdK3+VzK/5HXq0/GHLurgoMPfqp2XI=;
        b=SeFOPRhC5/ssLnPvkURel16bCdUidOatWUhmGUZwfxed/z3snE/kgUgXmQzhy5yo3E
         nVClvP+WTn0UJ/WeF9+LYL5HotQZ9Xi6G1Wc+afx814YLilNrp5Fp1m60O1batEFTZod
         00D5MWWKXS2lpbIRvcV6rjD3XbekoCi8h18i5E5AASbEW06pnOziWwn9Mc5tEkchHjGf
         3d6RRKp2Fl3FD4019m9pRRmgfAEim6LVFkuPcLUfzjvZ8NhgipJ73lYRVDc7pSfcBsYs
         Q8zNlssKo7OfXGqouLIaPhldg8gjfXc0Pzd1jpeRVoCOtLjDLRJYBa3XhIIlamzrS/+O
         mYWg==
X-Gm-Message-State: AOJu0YxGFXbjTiqq/95+6ovgaavo5V4YVMX4q3DkoAghgY0i70Y9Dkgg
	x0vQRvIWACT7smNRVkG0PWRjeWoVVdRWjOvWQzlrpUFLOAIACR+eGZI=
X-Gm-Gg: AfdE7cnKrFhuLjFlne2d9sTUaQL+EnR5oUMd94jnayjke/CN38Plj2QDpHigJSit+Fv
	v7WvKbNi665rorV56ZLXZAx0jm9TsTGc4QNx7tBtLE/ppiijLOQUwRAWbAnVJETIPOUGaYWOrmm
	Tg+rhle+gHptUpBTnJ1qzW1awkH+p/ZDCYsDBd8bdTbzNOotSjrEcBoy7kfJY2AaPldQxHWvh5p
	AOp6CFvAQZx7NLb2sBCl4rv9mNCoUqmgEuckJSY6bPbqreyO9YVHvSAAh1QqEO7UFWkqJpQWJRP
	GsM8cFcvtjgd8tTxlajVGNNYXU5wjFrXqi9TbYPTMK66oBvkO/QsaejYEWmEEZYoDVGlAlUhFAu
	eWo9yR1IKky8Gpxu2qLZ9r8eZM2D1mDT82Bd+SJdBVHKX5bqoas66eFWR2MRuSVZA27Vv96IS1w
	p6Ln2O5eTKylERQST49L3NF3jN
X-Received: by 2002:a17:903:2f8a:b0:2c9:97a8:afe8 with SMTP id d9443c01a7336-2c997a8b0ebmr73040145ad.43.1782739316725;
        Mon, 29 Jun 2026 06:21:56 -0700 (PDT)
Received: from [127.0.0.1] ([20.189.188.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c9e28d8129sm31529985ad.80.2026.06.29.06.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 06:21:56 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260629-mptcp_bpf_kfunc_fixes-v1-0-8cc875f36f53@mpiricsoftware.com>
References:
 <20260629-mptcp_bpf_kfunc_fixes-v1-0-8cc875f36f53@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next 0/4] mptcp: bpf: fix scheduler kfunc socket
 type confusion
Message-ID: <84b11a0e-626f-c054-3e2d-23a4d5d65908@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 13:21:55 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Shardul,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/283723=
91812

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c92d37631698
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1118165


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
