Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E92817A2E8
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 06:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762496026; cv=none; b=ispc/OpFJVDFiPIUcEkOwC/z1bBsKWSrnV/QsZedoQVQqgecUd/LaR33/I2xsKYPA80QtBHUpI+VE0oi70R+EgD4Iykv/0v8p7CIgMJShtgJhQ694SbK/tyonOJfzDxPNV1fkZ0ZvmQYglb4ECStXQN6NRXBaeaZ5Av3wjl47cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762496026; c=relaxed/simple;
	bh=oHoTYisPpOjwmTKDj/FY1rXt2TRD9ZOUP7+0mCruywU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Mm2L0SzxL6vjuMbDPej28UM5NJ1y9T98OZnPUBQhCTgPq1ZMw9RIIUHfGcm2G52ymkz7G4ZsGjvmthj6cQUZpK5xRl4GdjBOpXE3noXWCU4L4ijUS8Iu+siqrPuNCBhvNPu70XSD8YyHblJrhalyxBlXa+1WSXJuqC+ldyA2ZTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6h0tIZ6; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6h0tIZ6"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-880503ab181so4556376d6.2
        for <mptcp@lists.linux.dev>; Thu, 06 Nov 2025 22:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762496024; x=1763100824; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06vn95VsiuaGsFwpAm7BJXCovaB019uarh7pJoTmFWk=;
        b=e6h0tIZ6kyAOi6IP9v42f5DygjF3Bqr4Nsxj/cJgHGGvTGEmDTqL5sDFfJ0Zme0h2N
         WLZTif6NeWDLpmcUK5QRvWRI4RDBPSm449R2Iw2mPbwWmnEOGi+WWk+GpB1ci00WXFTO
         moUtneUc9PtX8OxJ5mQJZUG7eEy9WoimJN4o0nBECpxtUQdmg5vf4vLWL8ISVShD9JQu
         9k/po8sKrfaRlTuJtC4A7RM4fQNDnNjAlwJki4EmhwbLX09ykSHCEVAs4a3vRp7Upqxk
         GR3AK86JE3MTqTIY0hYrzR31uJaD8lPDyQV4s3WtE5VkWxSZB1bZDArRJD+B9zJk/64U
         tK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762496024; x=1763100824;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06vn95VsiuaGsFwpAm7BJXCovaB019uarh7pJoTmFWk=;
        b=wizdvY5XFO7pYAI1Jq916W2zkjV/Ia1Hn7hUt4Qk3vM12UbblZMztfVetJVq2DDYg2
         HFlM0yeMlARI+geosGlYApSIKtKmhl6mQk7Q7wWCfLr2pdbUgEf8d9noVNTsS9eRoGzs
         vKOIvpPtu9BX2ttqL6cgledDVQrTkG1kvNtYdditZJD9R5M4/eHWMVakpuO3sCrAszF2
         DontzLoPXMSyqb+Ufn4rit3nmyTiWNXtY37+SgMSNUuHV5UkfPyzA5yjQ/p1/QMj/FvS
         9m94HjpemoAO3tmKzLMI+iwWg9aU+xTLyJWz6fg/ChI4ldHQwNKUsxyAgNY8hUA1qFdH
         7aFg==
X-Gm-Message-State: AOJu0Yy5Aq6Ze8Ky9ygEmuqqrHfKqOdiQSUk5rRSbUQMMl0BvptYsCaX
	r+Q/emxgmIKVsg1ET6/FhC7sajswv64pNi9fZYOYXCckkYJ36EGsDXrtv744
X-Gm-Gg: ASbGncv/JyGvzh8rvW3aZQhDI0cT1nSwgwBDrMJ5HDGtoxnZ3/fvi+6AkvPY9ipMPfj
	Hz5kta3ZXy5c9EosElc3CK/Wr4ssyelwHsHU5oEdpt5HkOKDIBT8FefvkqOfqOA4VPE8cvohIbu
	QNUj/O8sU/MA6e7uSpmdCyNvIKEGu+fdygJw0gvNsSSC3q0gzoIDZiQYraWRShoIUz5ItCOgukw
	4r2TsGr2WXvjHIiBldKaWPQPOR8ma5zM0yhhvluJu0Fb3B2rseC9rszrmqxpLQWOPOekJ2sXBvn
	jSFWpNEIZNR4XAaK19+VIxCmO8LapSXHsHet0z/K/nGHqrjKJzvW+C0OKPWgDoJqTxM/bXrE45r
	vmxFumgmf65KmpTTsoUt5JApShbevFtZe6i6uWMKJXKk0pFwAYV9FDXCqdYNAiO9kmQpDl9vK/J
	V+3+pTcg2K8cY=
X-Google-Smtp-Source: AGHT+IEUPF6WlEn3XI8B2JgVG2fucNRbTG0v3BlymNGD37C+TO6i7HcGpaOgtc0Hr2/VCnO1EbwXzg==
X-Received: by 2002:a05:6214:19c3:b0:880:4d6e:1c42 with SMTP id 6a1803df08f44-8817677d285mr29853546d6.61.1762496023944;
        Thu, 06 Nov 2025 22:13:43 -0800 (PST)
Received: from [127.0.0.1] ([68.154.37.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880829c4798sm33784686d6.33.2025.11.06.22.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 22:13:42 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1762485513.git.tanggeliang@kylinos.cn>
References: <cover.1762485513.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next 0/6] NVME over MPTCP
Message-ID: <d06e3ead-11c5-ed8f-a738-9341b555953b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Nov 2025 06:13:41 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Unstable: 1 failed test(s): packetdrill_dss =
=F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Success! =
=E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/19157587224

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4d1bb0e3c51a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1020727


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
