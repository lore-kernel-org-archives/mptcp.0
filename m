Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792432592;
	b=E6PBo+Hbc8Ec4sPac6AADUSol1k0inT/UMFdfgJfuaVZ5h5yySHZX5TJBnwmwhELe+HW
	 kHiC5qhTrvsc+nXMR96LVtKzlhPjlk6hwVK/emMHlkc1U0hPFGIlowTIlJAhR0W3XbBMJ
	 P+FpdT9hpJU5WD2JNjY9brqCN5fRWunxtIDP5U6PUJsHhSkgc8aTADDy5mupogYCZRGsz
	 ZnMiKdBnJG0OGCXYqiLe/qYIu4xLdvdO5tGn3gxN1INgzHTTnxXP+v7VNTMIVLWr1/4AV
	 U29nlNVGCgwbVka2PhW4LI1s3CBKKCiO04ZHsQCQBpV7WytGGLtA8uQ4ul40A5qTLOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=oUEZZJi1vAM0jDTf/FoBlrVfbfDfgD6LhpLJHb8Tc8M=;
	b=ANZoU1+uJgeGuBGAd2yWYVPB3pv21NGFAaVTjs34jGlpYoCojvMkZbgr6uUf2OzhqcoD
	 sQuaUftvPnXiWU69SjaQ2jD342hG9PbZmjWivq0Ku7g5AgdndOyx3SyjovllHhEsnvO37
	 O6qhc2Fq/YIWabfpc7XztMctZtpUvGMUdGxG9zAOEehMM7iVPm+QLfYhISVDThQhfL+yl
	 xmy1mF7O1CCJPLLtrqKx3izeUoLab7Cgr3/Tyt8z6E8iimmcqxpDGUtndodTvmuK6KpcI
	 BI120Vq2W33inxp4RZ+IgQJY0fkbu4l+oa8eg9/pXtLPt+WBHPYlKBy2NWzlv/hbVyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BlFgYCeb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.49
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEA0606A31C
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 17:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AEA0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BlFgYCeb
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5be4fea434bso968659e87.1
        for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 10:56:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792432590; cv=none;
        d=google.com; s=arc-20260327;
        b=fbUuR1OTHsDf4iFKOVEXBfqMLctZBXvaXi43anD9kmFBrKz0PcJ/A6/8oI2doXmAgL
         ZN+S+9EfSXRZjR29NswIPR4lXU7OIAPgZ/xSe8GsY/zdtX2lNKNzJ0fb8e/l0o99lL5V
         4KoML246HXKSDGrGZLOy7JPY470N4DXCf5d6pR/Rsabnxr2iFZFH/9MotGaZJQrswsxB
         SZ/Ap5p5xMvvH2Fyt6ycO1fwGAc/Ia2UVnIilDErRNzCOZTfgg+WD+G3N4grdUDuy52Q
         sPvqBc5ueCK0DFMXFnq+W+tJoRasK4eQ5a8q2LUGvSMUUYA/kGVTvgF7+dt4985g2woC
         DyZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oUEZZJi1vAM0jDTf/FoBlrVfbfDfgD6LhpLJHb8Tc8M=;
        fh=f3DqXekhpmaMkf9TAUWRp+rzYWY1T5NwBBCIfHpCrLY=;
        b=Wtq9AtDlHKDYliZ5S6UqYaRC0bW5UQry1xF9Yur9My/VIAoMskiYhRajG3d29QyZwV
         f7aXcvxkQO21lkBZ1QjV3IS30jCAsdQ/P8eotweZ8ybKv1TyeS+xJesUNq8MFaguOpTs
         wO1vxncMWNdpl3RzERgvKVHpDZHK1/4biJpCFDVMYFZut9tLHSXGO0AbGtt4GdPJr5or
         9Dgv4JdHE37V+LH50Z463yGg1WMivayX/cFD2Xzu4THCi92yIS4u5KcW56jzqup5K9x6
         zrTv8OjCcFeGnNRcMjd5EO1ju0bwbxmGMOccbjKFU9Mk2waMWOjagyZz6MIN1Sfb3sZF
         ZdCw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792432590; x=1793037390; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oUEZZJi1vAM0jDTf/FoBlrVfbfDfgD6LhpLJHb8Tc8M=;
        b=BlFgYCebrzq6ehle0fSgRskNfSgsV/YdQgvvBqdPq774QeNIgEQEZGA1d/4tVUufSr
         6m8DPlVnEgKGeDHvPH8AUJbCN3R4gCicBObzHwHEH6CfRneCWL33fDU2HW9cg+M5Lfd1
         UeGpf2iQ52vyRWmTKEBFEsuWCSp9yAwuJTgLA4WA4rgfifoIMTRhnGF40Alw0mgopRnn
         Bm9DG95SSky42N013HliFoxcaApwxQw1bzdan0kBWdzR3NvxI4lKaXYiuIgeMo3Ijlsn
         vnf1Iik97Mgm9Wr72cFaBTTUd62VzcatuonGtn1zbAtzr9U8aCqHJwsLzTqwRDvmu4gW
         ewzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792432590; x=1793037390;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oUEZZJi1vAM0jDTf/FoBlrVfbfDfgD6LhpLJHb8Tc8M=;
        b=hPDR9VIYFLtiETf3NO7eYyw0vvvyswCwHwgog1ixoveg+k/86YUrHsL8klOiJDr4Ov
         5Stz2JmPsLeRnd3mdwd7P53eG/1bIoDnYYOVog6tfw7uxYkLtRuNX1t440CiU/Oe5BCX
         xrHcpK20pdQbqvIUfOonxc1AaPaom8Mc/A0/uJXLonDtxTKlE1pP0bEbCfaBftrHLNHS
         Sk+HKfQa/9UzQ/MJDaKVAvsJG5ua+NzjKyoF+SCMepqKR8JWAc0e1Tk1Jk5AsgefJ4+U
         OF9CbNKOk0oi4uSMNsvNP8UMpODyFqwQWjuu0VME1hSdCoRuyAtYO7OZ58Vjh7sMxRuf
         oDmQ==
X-Gm-Message-State: AFq9FYLEBPDQ6KkgcPENsJTjmQOzqCGgqaz2/vj21SxjViexBqqyKFsE
	xSnuRSq1XfZUuTg2g4q7vZppAus8oiWq2pmpF16a0ula2OQKF+2Qp1Hf2+ghUH1wL2g6bIr8Ji+
	KbNub7TKQN/HC+AYlDZqnIrLFEIovVSc=
X-Gm-Gg: AYBFou3TxEOKbePLcbGZgO1wHpYcLLfe+BG64MXFAHqUrXrX277x6+3evfeeVdZyiC2
	0A4SKGjK0koPFtfOGaAg6vpHHATj//4AOUqu0jPRO5+WDuCDEyIMj8Mf+Gr7SSBnau0ooG8yR38
	E0bCdzkoh0HhL8E+b3gDbRbOt3IymsZgsJ/5PWQYTquF5dKFCg92ffCj3oo7NS/WJDyqgiNXh81
	+zVUHz5a8kGxniK6c/Ja6KiCi6N4V3P6IDkrJ/zyVaMoI2o0N7LH2WVrWB2Fj3UnkNv4UO+51gu
	BBH3XMaz8vMyaC+TH5/DT8jVpzAQGEtCsy1ySL2MjxF9D6WWGsgUmLs=
X-Received: by 2002:a05:6512:31d5:b0:5bc:f2d3:f949 with SMTP id
 2adb3069b0e04-5be479127d5mr3632089e87.25.1792432590220; Mon, 19 Oct 2026
 10:56:30 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261018041748.1655711-1-anilkaushikwireless@gmail.com>
 <20261018041748.1655711-5-anilkaushikwireless@gmail.com> <20261019172646.212143-1-w453y.me@gmail.com>
In-Reply-To: <20261019172646.212143-1-w453y.me@gmail.com>
From: Anil Kaushik <anilkaushikwireless@gmail.com>
Date: Mon, 19 Oct 2026 23:26:18 +0530
X-Gm-Features: AclHuK_MRPkj9lyClaBiRSe0GZMzYqq2gIDoh6t3SgQpjJj61aWYL1aDV4JRZmQ
Message-ID: <CAG0Mgm9TunYCsiSyp=Se=uQmq_kzXO=M5DF6wdVtsh591NwENQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v6 4/6] mptcp: pm: in-kernel: retry subflows
 closed after an error
To: Abdul Wasey <w453y.me@gmail.com>
Cc: mptcp@lists.linux.dev, Matthieu Baerts <matttbe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Abdul,

Thanks for testing.

My comments are inline.

Regards
Anil

On Mon, Oct 19, 2026 at 10:56=E2=80=AFPM Abdul Wasey <w453y.me@gmail.com> w=
rote:
>
> Hi Anil,
>
> I tested v6 on top of export (8bb146c4c) in netns: two 10 Mbit paths
> with 15 ms delay, the second one blackholed with netem loss 100% in both
> directions during an iperf3 transfer, tcp_retries2=3D3.
>
> Upload (the client sends) works: without the series the path never
> comes back, with it the path carries data again 4.5 s after it returns
> for a 20 s outage, and 12.6 s for a 60 s one, the extra time being the
> SYN backoff.
>
> Download (the server sends) is not recovered. The server's subflow times
> out and is freed without sending anything, while the client's subflow
> on that path only receives: it stays established and idle, never gets
> an error, so it is never retried. With keepalive enabled on the client
> socket (idle 5 s, interval 2 s, count 3), the idle subflow times out and
> your patch re-creates it: the path is back 3 s after it returns for a
> 20 s outage.
>
> So for a client mostly receiving data, which is probably the common
> case, the retry only helps if the application sets keepalive. Would it
> make sense for the PM to probe idle subflows it initiated, or would you
> rather document the keepalive requirement? I'd be happy to work on the
> download case if you have a preferred direction.

I will document it in the next version.
 Application that only receives data should enable TCP keepalive on MPTCP
socket. MPTCP already copies these options to every subflow, including
the re-created ones, so a dead path is then detected even when the
subflow is idle.

Probing from the PM can be a separate series. Please go ahead if you
want, Matt may have an opinion on it. I could also work with you. Let me kn=
ow.


> With the default tcp_retries2=3D15, the subflows are not closed during 20
> to 180 s outages, and the old ones resume by themselves 17 to 24 s after
> the path returns, with or without the series.
>
Yes, this is for longer outages, or a lower tcp_retries2. I will add it
to the doc.


> Thanks,
> Abdul Wasey
