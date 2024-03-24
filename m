Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C7318021
	for <mptcp@lists.linux.dev>; Sun, 24 Mar 2024 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711299172; cv=none; b=telq/x8bQ79w54vlVtLzvm0BJOyco+rxLCh9IP/KG6gE/XbnyQqLnGVMpsfCXwGVeoK1oLXkstWvycM4gP8rglsuZ14TpUHkXggz9TOsBGSdt3FrBodlOt/+nWQ8sSgA27HNzEt8tN2zJ94e2VSSzZwj7lkSmsqyvYuQYBw70Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711299172; c=relaxed/simple;
	bh=maxpwE+NWZtGie7ib6dUyciUHG7oA+YiLlCd2rPRdxY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=GN13H9WAimv66qssACO2/yoxDQUVFWqm73VX8O+n2c3ZaTKHHxM87hnGxRyYx/AmoprkRYVHTtrQnNh6pWxGG/fPTFqeVu4pBtRLEuZtcE13k6cHBeSfyA+GlBOD5C3rFupOd1znCvl3ZrBHIh4Qvr+DbnWh2Md4JSQGGbRRY8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivyevAHv; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivyevAHv"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-696147fb5a7so36528936d6.0
        for <mptcp@lists.linux.dev>; Sun, 24 Mar 2024 09:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711299170; x=1711903970; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GewHAWS25UovDpkdaU/7aRfUtB1mGh3zHydY99mKMk8=;
        b=ivyevAHvDUBbDc+s2V6buYQjhcJk5+QaX906Av5WFBK+jmju/5ytwMXSqKf3IR2L40
         ii77iqdDQOjc2CLPT1XEXELDLVdjseIpE8IguJ17vDonhkh7N4JMxlMKExUSC0qCgkqu
         zfcm3gNRng+syWTkWU0OpuUeGeMg9q8GPVQo/Yc/S+9sHf3gk8EP0d30zQLaFrVgV+x7
         zr6RqP4N9mBsaXnWK9Wo1WtE0pk3DXU7PfAAOfKel6ykyhlKrt+CJN5N8aD/OoWc8Gmp
         Rdzo4NQ+pviDE2WEDfRiDoIcNjB4HcrOYYy5KsUYlvHTR1WB25LxBJJNzkChv+Vixk0g
         2F/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711299170; x=1711903970;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GewHAWS25UovDpkdaU/7aRfUtB1mGh3zHydY99mKMk8=;
        b=B+TQeY/B+/IhNWOTEEf91MSViet122g0r5vE0J1rKTDZBzZ1M0FsOI7zQthFTl/Jxe
         6t9yGO+ILCSb5cLt8MTRCI2LXTLTAS5LrnUnuA5RpFRA5Z2q7Ij6xEPDIpxr6pX4mvBy
         2i87kCSUOlEp34INoCEbFmQEe5J+QGkXyPeBzomEdc2zuiYoRyAwCRZjO4bO1zOCf/+h
         gUcOKpIbpeRBdKKL2kwAGMAyNIHpllQpie53ddy6GZzv7Hi+kOt7FjBhfeSyUd197LTp
         ntVOfUxtQPLs2FWre+RU8faKFNQcsoMMOVvrKIWuLVCm62yutVDLtZAhMLtJOu8yeqNq
         SilQ==
X-Gm-Message-State: AOJu0YxjFhOmEgD3SheiGfExeiZHZqr5mHv3PwY2DaGDbpUJseBXuAYF
	U0CMRl1H2S71oSIA+lhsZEfpiz4WXdPyLM+nyzAhFb1Wy3eROPqvcspQG7o=
X-Google-Smtp-Source: AGHT+IF6QWUOmqvYkRo1Vj2zlKJzllAfquZIa03sQsTY0Sdg2LpsTXlAjfwr030Eq+3dg4Nje93MnQ==
X-Received: by 2002:a05:6214:19e3:b0:696:46a7:9f93 with SMTP id q3-20020a05621419e300b0069646a79f93mr6124880qvc.45.1711299169942;
        Sun, 24 Mar 2024 09:52:49 -0700 (PDT)
Received: from [127.0.0.1] ([20.98.6.135])
        by smtp.gmail.com with ESMTPSA id mx18-20020a0562142e1200b006968ae44daesm488656qvb.106.2024.03.24.09.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 09:52:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1711296000.git.tanggeliang@kylinos.cn>
References: <cover.1711296000.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/4] setsockopt per subflow: BPF
Message-ID: <16c3b241-1852-a4e7-13da-e30382bc950c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 Mar 2024 16:52:48 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8410598308

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/bf4971d77728
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D837630


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
