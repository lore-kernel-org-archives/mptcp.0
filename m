Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A2A817
	for <mptcp@lists.linux.dev>; Sat,  6 Apr 2024 02:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712370857; cv=none; b=F6k+yDFHW1POvjn1zJWRS4/th2zt5ZECVfkV5XC3RwmvV295DEuUE+gTw03EBVZHjMSnUxLhb06xAGkHyFip+6ZbeSz+gFTLh1uEsmMLbYFMZNZ/I9bDZMDokf8ZiylWYNaIrovL+1IXtuTStyIlIBDL2AmhL23b9JfKiDMvCyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712370857; c=relaxed/simple;
	bh=yjbSJVCABZ7jxL1RJrDrs3054DCa5ubsvULRjLOOiOs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=iJHGhtCCmL6tGe3Yqm/cckypv/BNQ3Yfr+jvtvb0KuefSKOmvAmA398GttolFB7nxwXVaJMRV8OKeR+mpkH5QDT7N4tIRfddLY9ohLoR74OA6Q/EX+HFs28XdMZSqHmwK+tLnNmvIiEqqrFqtFauEGRSrluzlrIZF2vnDSmKI14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxcwMumQ; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxcwMumQ"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a51c063f99so1513084eaf.0
        for <mptcp@lists.linux.dev>; Fri, 05 Apr 2024 19:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712370855; x=1712975655; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j96nB6SbuT7MpKyBOt9SUnrjIsPwt7ZtJxogoYwhwV4=;
        b=QxcwMumQryiqhYgZso5romYG1sknOMTcwjWhnpaEs51uBFQ3HYaD20Ah02QVCrUFXc
         ZnFLVXudJ5xUtvY7Orxi8ONnurbWaY90FopoKF2BVnyFaH3KCZfTLprIwqpzmRHRRsnf
         bZkOtWR90xxf+nNuTnL5t7cZjtMdRaNG0+et6QWmWu4lNSU+UO7SrSMl9xXplE2t+/+o
         l/FC1lvsmbpdnJ6stqIOUo+u9a754R9Rk18Bt0zUZBmlcMkUsqWbkEEhwzRPytoOcUgE
         67XA5AaaT8byK4FI6Z/UVK8XpD7vpBog1JjJ536o2wYJv5rVw6dqrYmg64O6mnu9dIal
         M/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712370855; x=1712975655;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j96nB6SbuT7MpKyBOt9SUnrjIsPwt7ZtJxogoYwhwV4=;
        b=hFuAybVIZdPW9MqgtuWrJQxCrPDyChCQf7RwAkgysPo7inaKgsicWp1cfCCXFnBQbi
         weZxaJZCRppVMhfvFC8LOO8Zs8ccrmslHfavFHf1+vTxL2UJIJW+w/G65WRAmvLD2CCm
         h8pTjCFVh2rDpn7F1L0dyPfWreftcK71O5VtDP925V5zPCvY/tsTaWjTmWGUt7EAo4du
         rgPTX0VSHGh7YX+0002Ya5lz5ktG2RZtvZM6NiRbkIEtgxzoByAFLfeTmj/Bsyael5Q4
         eTovKWROHYgnuu0Ptzis5LANlAVe6w/dSp6jw3UFvxDeCoxZ/4hod4R+BhdxLP4LtFw+
         kqmQ==
X-Gm-Message-State: AOJu0Ywd037F9qbjOazpbw8fiPp3PtdiwD9c09P9c/kXcFT9cKUfXD+Z
	ncvAuMnFzkz7NCedXFWOEiM1/ItuiWWxDbCVBfWWaBs/Rst2uuE=
X-Google-Smtp-Source: AGHT+IFOMfrHI67NZU/mGeJtc6AvOUfvljmXjsnoDIf0x0iEQu/FQ/JlJjmXJkYIbmv3z05u/EV6RA==
X-Received: by 2002:a05:6358:d59b:b0:186:45c:d6de with SMTP id ms27-20020a056358d59b00b00186045cd6demr873681rwb.26.1712370854912;
        Fri, 05 Apr 2024 19:34:14 -0700 (PDT)
Received: from [127.0.0.1] ([4.227.114.102])
        by smtp.gmail.com with ESMTPSA id g24-20020a63dd58000000b005d66caee3d0sm2167681pgj.22.2024.04.05.19.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 19:34:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jason Xing <kernelxing@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240406014848.71739-1-kerneljasonxing@gmail.com>
References: <20240406014848.71739-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v2] mptcp: add reset reason options in some
 places
Message-ID: <eab8e0e0-574b-6f8c-4835-c4a62ed6efcf@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Apr 2024 02:34:13 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jason,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8577922431

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/34e227fd1ebb
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D841989


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
