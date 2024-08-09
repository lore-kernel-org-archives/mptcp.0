Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6708317BBF
	for <mptcp@lists.linux.dev>; Fri,  9 Aug 2024 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723207393; cv=none; b=DRhIc9ABvk3RiRmDMn0nluE2dhzCytfzTcO+HH6oPE2vf34iDdEQ7mo7k892KwA5460l+/oKHzcAJ7+tYwGuFoCBBoHMlxa67XRlAaZOhAnsJ8ozpVlAZqn+VXF5vZIGlrpBeC5Yz7zf+hWOPinse7C9EmJqXLnbYdWF+36kWjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723207393; c=relaxed/simple;
	bh=Et38eVbiiCdwtvphtUUtGC3NX0cw0PNqJDI8V5mswrg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=jJnY2UeiCY31uQ8lCs5l+fs9lb+NwQTk1dAkqKABaSusryO1HVLzf87dxfF1MiGVILebBdhC/rlEy2tttT0ZbbjpCVrNA/N31bnwJ1YrR8DF3AJb4WWW/6RD0NoU+AgALUN0wQRfZrCAHKUsIH6+9RUsd9nVJlsrJ0tyO4rW/yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rp4PiVLF; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rp4PiVLF"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a1d42da3f7so116533885a.2
        for <mptcp@lists.linux.dev>; Fri, 09 Aug 2024 05:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723207391; x=1723812191; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ND5XJtNRNg1RliuKKF+3psJtk63L9qpS9pjJZUHvi04=;
        b=Rp4PiVLF9IKBnzI5B5HVXujfinnKEsFTHcQn/vNeBDcuzyw9M7c7VTmskFHGjkyPUc
         PoZ1Nd0FU5v4oMZZaa4NT06ymK1d+8nCkwxKbb1u1amy2THEZaeZEJJDglE02+cOb0Ls
         eSgmupdKSvjhMpP9DLaNJCFbnIK1QChy34qauxBSI0O4D1mklGv0vNZXb6w73O8sgZl5
         3WFRucMGI/8AUWX0Ecp5tC8IOl7kh1+eFFORT2NFhXadSXLxdEcRSUM1umPYnhRhGNl8
         sLVjHlPTmmfOheitIj91QfneA1LHuK5am/s9MgTBqr7zjNNYBRv1c5CKcoGXxXi4FeO+
         +DIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723207391; x=1723812191;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ND5XJtNRNg1RliuKKF+3psJtk63L9qpS9pjJZUHvi04=;
        b=bzVo8LXovALPdRStSBxMmZE+IgAEyCmkqQS+er24zuI5rk78x2xFM0gC3fwB8TwxGC
         U9pj+E+uCUMUk/H2GMRg49ILt32tfAkJ9YwL1krzaldNQ5IbFIIrHfV/9gmt+eCTUKvV
         dkpwWvRjSmfDDMKNONYK6D5B+vUQZ5L/Ed3qyfbv67AxgAPPx86rYAiYg5qjCVYEIOCx
         my1peN5Kibg01q7w7R6+1djiJ3LAgGvUhO0lAzgkm/SjlYARM9RudWPOl6zt7z2CcgRr
         kKphOJzb7bxL1kRFk3ScMuaDaDoONyAjI1uLhvS4WadImNRJQO3YkdHsJMd9E883t3Qw
         lw5g==
X-Gm-Message-State: AOJu0YzLmQ0fkqE1QzWBuCXXWzUZTMAXLUjij/WUj3eubfFeJYMFA3ua
	eEzKCO6RuKzXTjmlDZJ0ch7dIonj1njaJpP343FPMcnyVXQa4FY=
X-Google-Smtp-Source: AGHT+IF7D37gs9c3eWT4KlBWHRZeLnVNXQn9cBY0w3TNg/5JWGFPlC27CN8y0FR0h8nByi29IkOesQ==
X-Received: by 2002:a05:620a:2950:b0:7a1:dff5:6d74 with SMTP id af79cd13be357-7a4c17ac49emr144048585a.28.1723207391218;
        Fri, 09 Aug 2024 05:43:11 -0700 (PDT)
Received: from [127.0.0.1] ([40.67.135.166])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3786cc5f2sm257513885a.105.2024.08.09.05.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 05:43:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240809-mptcp-join-tx-mib-v4-0-98b0b0e098c5@kernel.org>
References: <20240809-mptcp-join-tx-mib-v4-0-98b0b0e098c5@kernel.org>
Subject: Re: [PATCH mptcp-next v4 0/8] mptcp: MIB counters for sent MP_JOIN
Message-ID: <fba3eabc-5d9c-c780-cf22-a497c66a12ca@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Aug 2024 12:43:10 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10318863223

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8cc9ef30efb1
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D878183


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
