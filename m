Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDB619F489
	for <mptcp@lists.linux.dev>; Thu,  5 Sep 2024 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550025; cv=none; b=cldTnKXZSHj88ghvi9en3Sg9zh0tVLH3ZwGJSE1bTkBQ3v6BMp0CUmDhusP1OxgmMshGd5RtC+9/4y6uH5mVz20f2mZSDfD7eL16QTWNpaRCDkJSwOrgEmHSPvcUbW6/d3bsOYJiRkW26FxKzvFtBfZkW89G431Arh9g1p15x0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550025; c=relaxed/simple;
	bh=sEJKvZeeh6QAzQygYgyYmIBk/m7F+eWALMtMifHhc3c=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=K7JbAeZ6dfdq4DWOT7Xcr1qdvdPm1/VR62xm+746Gu1dEWaaozizA9KpEX/H6VOKVVEdyL05OzHfHpOSUVxWyhiDCqq9Vn0+dmMljpFUMUREjqHydCy1gS52e6ioPeVoheoOdOV5w6jKAZQoSPsDLbFIPVHxKUvO9Eo8BOY3w64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/Bl0Q+R; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/Bl0Q+R"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a8125458f2so61049985a.1
        for <mptcp@lists.linux.dev>; Thu, 05 Sep 2024 08:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725550023; x=1726154823; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4OcD7TVLGQUfDdeIClztOpXlVczkSV06gYSLbP2n2g=;
        b=e/Bl0Q+RxQ74Ama59AtFIfsgI3P/qVpjQaDoNBBWa6Tr8v9ZYOgrThTfpCdu1tOOtU
         r1ezdVdBTQHG0a4B3dYtnkKKNanTsFC5ymOy9XSWOiHZ3P+hRbuyes+sZRBFSx7fKnpi
         EyGim6qYq1y8GTuoxc7j6RWNX+PTO6EZI4Xid5XznMK+2N6darhVK12EAiL4ZWaxpEba
         nx7wpFfKJ2M4JcVPIzM1bCStk6oQXhtwp9B7TFuj7JGi0zAkDUerSNdaenqqXZg408Rm
         GUn7sTBomxOqd7b9YkP215kEd41igT9Q0vJAF3GX1BNpKDL2gwx/p8QmySwDqG2nFPUj
         Rraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725550023; x=1726154823;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f4OcD7TVLGQUfDdeIClztOpXlVczkSV06gYSLbP2n2g=;
        b=L4jTHsO7g/karPl+/Foig0J0jwAUA0jwuG2r8TggMyDjkCizo56Go52DcKVuRftHJg
         rYJSIohCoOXQQqHqhNHQnk7zNivDIOUszsukas1wLDabegT/7Qyu+1K1yVJBbN+4rt5U
         /md8B0eVR8CT0hgqXTs5Q7BymbcRrOzJq7jz/1DQaFKuPNaEfKQ6U/QMuMaoqmKLJsKX
         M9ujFzwlNDheDclN5HahRG0UbbkIyXvjOYfmAENe3lntBKpfWscvfIjOg5OFHWKYGSfn
         DgOvXUqa9L4xZk1F22pPmYmSAWlYZwPgW3xCvEzMejtvqbycQFiY9M7MavOwQhZyRiqR
         jRWQ==
X-Gm-Message-State: AOJu0Yx/i/t5gV8j2T/XiH755owjdVq3XKzOkE6Yx1v247vXOX2p3KQz
	m1TKL4AjQHerJKsz26z89aP6gvCouGpLjgo22Yryk03vK2BsS4NNxpav
X-Google-Smtp-Source: AGHT+IEDEpjJpLE2C6IdMNISkqnbe28M4XG6UJGsnnPvtGt74LChB4AnLjafSFpbVUs8n2Pe2DhgJA==
X-Received: by 2002:a05:620a:458e:b0:7a1:ccfb:faf with SMTP id af79cd13be357-7a89abed9b4mr2064227585a.38.1725550022768;
        Thu, 05 Sep 2024 08:27:02 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.78.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801b36092sm7962221cf.38.2024.09.05.08.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 08:27:02 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1725546472.git.tanggeliang@kylinos.cn>
References: <cover.1725546472.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/2] cleanups for bpf schedulers
Message-ID: <eac84c1b-7f58-6473-cdc0-259457e899b3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Sep 2024 15:27:01 +0000
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
uns/10722750441

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/bd5b4bab43f5
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D887280


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
