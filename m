Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021133BA23F
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787767299; cv=none; b=QS/a9bbWAuFOcJPcUGHZbEA9EroAwLAkMKaEujaP0dYYqsP1MYK4NfRdadJgoe4x3KJfQxwpGd0X5HGOwO9BludJCmYMZxPP0Caw2DhUdBD7rVwxih0zuti1TBLJPJy+943y4mOIDLr4vVpihViD+OjzDbC7FI5S8JiW5mZWPf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787767299; c=relaxed/simple;
	bh=s8FsPYfj+r5WaibSeQP+QjdVYfrP0tLo7ADCw+Es148=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=R9h0OXj0fuzIHDtH1DjS+M/ZHXzYdwtpDwVeCXMDQt9AHHZyDp9OLuhtr404LtcaGVuZ9cisG8OxA3FdtfchiW9Faiq/vaST2pVuRZy1cLXIZFTC4NtRWzn5y2luFCmzaJanw5rzIaahhpKavueWTNulsr7kZQg4fJGo9/DlXQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLNJnwGp; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLNJnwGp"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so1114407a91.1
        for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 11:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787767289; x=1788372089; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TaGJR4c1qVhmWxfZ1M7O40QNEI8V0I+zrI0jdiN2tSk=;
        b=XLNJnwGpm0iiZdg8gQzioPm3gNrtFtOPgxwLbrm6vS8DprIY2hfsaRM5jJ71QWXGhQ
         pmtyWeHyr0U03xNnJPkeJmcODZWdz8IHCbvJHVtXlZsLj6cgk6RrqSdLEC0BkN6O9leh
         5cTq3gSDUpd5qAOwWMeCSBksI/omuGA7feyg4M8XcAhLdnwhX9eTExGdNXXcwc0JfTx8
         pzCffOMw7N9NZS4phPzh1QlB+EvSgfE1s62wkECdJLCsvlQSAYadM5j8sm4IftntowgX
         eY55msq0Y+ugvMTiSmcdFxYuvXoJGmD4fm9EcwM4bq42AO1LQ5CZ4DLQ7IfNiWQRNFBv
         mg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787767289; x=1788372089;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TaGJR4c1qVhmWxfZ1M7O40QNEI8V0I+zrI0jdiN2tSk=;
        b=g5K0XuDyGjxHcfZg8E9RdaNwnAFjS/ZnT7syBBjiJDCgr7gB53+YEFT66vqY9l57ZN
         3M0zxi+3o7B04a9Yr8C7QY2g5T+UnAYbF+BkxuqgBDLQNFTCYuHzSj44zivxg4mVRK8G
         nQ95NAxYMMqrEjfdZjPUOg4CXxlf8ySbcELX+8m3FK74uvLO49kHaIHpckKA/w0Fi4Ja
         dEw46W+noT7Qz1ikut8u1F/LvDbMvMSHgVu++4jYiFIxrPxfB5UJaWcey7W3JVRA7MN1
         33+7kosQ/cyJgURolZBIRATCMVPI14NB5mjXMO2YeQXihYFPeLtxtoUJKiPTub+klGOv
         M12A==
X-Gm-Message-State: AFuF++mGZQjmLnlYypF3H6QU2mHpkUMCUcMOID8oe54XDlG8KilDch+t
	kBa+OlZuSRJK4sXt6lTulocv3rqva0nNgUcF3nj0IlAf0QGP86uaOOM=
X-Gm-Gg: AR+sD13SpS+AU/QPIfH0X4EKa5sr7H5cxVdeHvodLR/8M9oPiZiXo0Fh7333Xs0mzaT
	0UbsZzMwgBLbMZODm2nrGlv2ckvz/jzK2qPzqYhA4gXgEe5/GJxLtXtfVdgeU0zvq85Js/C2RUT
	ukN+cCY8KdQUeg869cmxTV2q1q1dxTc4exp4U7WpngEdSz27ZcARoz9KQuJjdTZCOoYXBqEh+i4
	53s+PSjfk+TVxVsNqbLWhy4mIqctB+48ZyHagN+2TKLn1oNIqwV/xjWysozHLRraN5JzbhNATEs
	k3tnxq7Y0Up+aaJ5MMnaCsg7PdgY/IwwFR6iCgnZpg8SyTNrqIBlf+Ok/Dlxfl6LmMJv+Pg40s7
	w4pZmPDhpaqvM4t/0dban/DHtA8TLTQ4EXhRyWl+YbfEZUSSE+fu3oONBCQOD3DWf9ZFaIFKXzs
	Yd8cUEcs7PKt0nOBjcAV0uNhRksDd6VsMyR3KDJjPX+yyI+VzUid15UcS7vBmyWLlhygB72DX34
	rvP
X-Received: by 2002:a17:90b:3b52:b0:396:602a:5bb6 with SMTP id 98e67ed59e1d1-3966d20f12cmr15908543a91.8.1787767288740;
        Wed, 26 Aug 2026 11:01:28 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.217.245])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d8d208csm10242495eec.23.2026.08.26.11.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 11:01:28 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Cen Zhang <blbllhy@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260826171344.4133-1-blbllhy@gmail.com>
References: <20260826171344.4133-1-blbllhy@gmail.com>
Subject: Re: [PATCH net v2 0/2] tcp: fix use-after-free in
 do_tcp_getsockopt()
Message-ID: <f455e676-2903-916e-69b0-6165a2b5cd2c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 18:01:27 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Cen,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Script error! =
=E2=9D=93
- KVM Validation: normal (only selftest_mptcp_join): Script error=
! =E2=9D=93
- KVM Validation: debug (except selftest_mptcp_join): Script =
error! =E2=9D=93
- KVM Validation: debug (only selftest_mptcp_join): Script=
 error! =E2=9D=93
- KVM Validation: btf-normal (only bpftest_all): Script =
error! =E2=9D=93
- KVM Validation: btf-debug (only bpftest_all): Script =
error! =E2=9D=93
- Task: https://github.com/multipath-tcp/mptcp_net-next/ac=
tions/runs/32995824882

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/054504491348
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1152216


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
