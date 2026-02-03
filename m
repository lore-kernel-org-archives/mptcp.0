Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC142AD10
	for <mptcp@lists.linux.dev>; Tue,  3 Feb 2026 03:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770090252; cv=none; b=k6Zp8c/rDS8xwarDg5N9e1Ip37LbXXdFojrcyiYOPxsKWWVMau5Nd2blBl4pQNEH1KdjP2wUe6bXbpSxbgbcj1i2Q7jKOsJjA4Qio1gv/ue28wguyBRA4VMq3yPcJdI9+EVY+6ARMCGTUZnx1UMw/ffLx1iypbD/Ut48b+mHLM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770090252; c=relaxed/simple;
	bh=YAz0+7KG1uaE6UZgKIr/NN2iFHiIqldcuwQ+UDHb8rs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=HhFMikkRzPMOGwWzrsFtdb6tZOWi7bC6oEYiV3AnlJF+lJRXuXqLFmWs/aJPpA3Uy5ltHH/nZ2QHhar+HMboP/5FpCrwdy1o7yU/CCdl0FTutFR9h8mTVn2Qsj+LNR8qTpix4YTV00zD2XhPLpLEqD5iijBInLo4ir75veXWSJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgnUc6uT; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgnUc6uT"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-50336cffef9so40007841cf.0
        for <mptcp@lists.linux.dev>; Mon, 02 Feb 2026 19:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770090250; x=1770695050; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwBZkfUi2iSHW4ydkR5WuWrEfQZO+laLKhV7XuBKECg=;
        b=mgnUc6uTBB5sVwCZq8wfmnZdq9ORDD8Wn4SWFWhH5XFr/fw0qTuNsC8Ou0HDHddj6o
         PzRJTzVvzsRrpoDq1CI83Pb3ItPLtozmJnPTamHafOp0zxlXR9mIifJDo/ppoPSqErbn
         5LShy+pAeKzSkv9AIGvrq/lK/cKQv7gVH3gwOZmtnjrZXTXLgUdOaDVjiNHvkM31WUgi
         Wvx+ICuM7p9h2x1lXJB8GW8GKEFWtm/UCVaqqhYssHrdHb4DcNM00BXm+/q8ok/glGL4
         laXSHo96BxlkT0uRipcfm7segwgsWVSXOatgXzFlOIAwvJTK6lmiC6GFmVLXTRrnvzCq
         SBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770090250; x=1770695050;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IwBZkfUi2iSHW4ydkR5WuWrEfQZO+laLKhV7XuBKECg=;
        b=Zv0EqfeNRapdwj2Xu0aHNhKy3gpEXzCvE5C+z03iZfs2xE7QRTTB84jp0QaLFNxPuA
         L1sKs/9iy6Sq3dBJPQUG58CnmKqYHXCx9XHedh18TedTJ/2Zl8cD8u2pnZxbZQhjfi09
         wNuLxpZt5SFWFqvf29aJDc3MgkFCasW21GN9GqIuSMOkxngt6tW48KhncpGMJxxZqJzg
         ilFwUTiXuCroQYy/Bg+E9TPH81YkA90L9dpx/4XWslKPhdT1s4/3DartXO5g7xfRl2gP
         2elg+3ZYU3OBVwoSWqoVLAxbpL7il5OFfWhTfJYCXX9kimKgCqZCyRJmBQrUDDciuhyY
         wwtw==
X-Gm-Message-State: AOJu0Yz8rzWP+iGlIWzjIBV/8nzbdj28Wn/0GCVG8fSyJwiDfti0kN6C
	qDcHbu4rsp3w6/OyHmzItdLqFkR/aX6EvY7mpLP6hDyJhmMJQpdPGyw1n/kXrfY=
X-Gm-Gg: AZuq6aJREeJ5KGSenxm6iTnkHH1BedjmSFwLFqBvyWiQKQHUN7gS2HVD3ADius7xuUu
	uqpa8tZaWlFxOa/Ay01NocbddHtRvKqbAOS0okmYOCKoH9LzKBoA6Jmq7kp4FrKJRfMtvzBRPeJ
	P10dmbvxplQOH2FEiy9hkdsS89JfLK2OQRts98divLysTOGujD3AJmTnqlZE9vnq50R2LzL00t6
	seOcGlzPCSzjiwCRYsbIpHjg+0OuBaDQKSHEgykZfaYPxYc+/8aMGpYEvbZ2EAWfIhDakXcQIlm
	+jplIWAiiKi+BJkb4ocytBYtdGYEijM9U/CZ2kHasVxyuGSc6vlQZoiSR8B86C5PcpO4JhSs+tb
	0opHjy5iV2FX/hRJWoGVZonLJdySUUCXvSaxUZxGKGYYhyWwxcJGwfdpkTITPBWHvFIikNRESwG
	Wq84rGbhR0ZBR4nvcKwaL2Ry0=
X-Received: by 2002:a05:622a:607:b0:4e8:b9fd:59f0 with SMTP id d75a77b69052e-505d22a9b05mr146861621cf.61.1770090250054;
        Mon, 02 Feb 2026 19:44:10 -0800 (PST)
Received: from [127.0.0.1] ([20.109.38.164])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d5c34asm1348881485a.50.2026.02.02.19.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 19:44:09 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260203023029.855434-1-gang.yan@linux.dev>
References: <20260203023029.855434-1-gang.yan@linux.dev>
Subject: Re: [RFC v2 mptcp-next] mptcp: support MSG_EOR in mptcp_sendmsg
Message-ID: <78c1f223-814f-4ae7-99e4-011442971029@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Feb 2026 03:44:09 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_dss packetdrill_fastopen =F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/216149=
81304

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/68562b159b7f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1050034


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
