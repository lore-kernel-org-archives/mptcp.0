Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7732E92A8
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 10:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754994465; cv=none; b=lTxNDiR9m1Eh4eL5tkvtY/z7cusuDoyuYrktA09IQXRukzbQahdvKCI9GHOFmozwflWV3UZEIiFv5BMYKaL2CiEZZwxwhBlj1dWnTnRCgd+9zhpszcjq/jpCC10m0PHQBaqF7K8SPQdwU6+h2mUmXzgnWB5lGk6jc5EXVL8LzjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754994465; c=relaxed/simple;
	bh=7UTlXI5DbOp2dMfVAjW/VZQVvM9Nz/fl9b+an9K0TAg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=t5JTD7l5pQlojaRLnFGnWQ/giJW22tIRHsSYFjU49ALLz3nd67q0gZ73VrKOzXzUdEmMkkz9o3NltCJgjUwW+eLJcO0akLIRygtPrO0o1RnY/YnOfbslsrP4auXELRM7WffxQ3rMLIA9SuHh8ZYPhKqFjt57E8vbAUt8GquU8S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSkDLwcS; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSkDLwcS"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e7fb58425cso766951285a.1
        for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 03:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754994463; x=1755599263; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdjHk3t/xeSS0sD4JAeDRd8plm+aeKsN6vpKm3JcRIw=;
        b=JSkDLwcS8nZ2IY64M3uZFa5GErYXvK6CuSHOn3nB/qZf/l08X9CpSgvWAK4DS7zHl0
         D3F9GC7kAEsUgwOa3kKj3wUegQHhuKmi/jBExtGvwfQA6KHCom2gkfRlfK3kCfEwlvNy
         TPPJbDDShsmcnB5kWGc0yJTXvXx+O7ONHFofbsd1o+rqi1lGdX3gYKJ++atziv+Xl881
         j0dFTAqTAqJzBXtf07gj3tBmXmrkbp4d6TsAh6SbSbMBW9Z+Nl8+MMamZXBmQxs0nLxS
         UWZvmm+tPX+rbTRZz/9BCrLA1Agtb30FziK6ocveMoxzxjVTwayJUHELWmyESUeLnjBi
         cG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754994463; x=1755599263;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jdjHk3t/xeSS0sD4JAeDRd8plm+aeKsN6vpKm3JcRIw=;
        b=CrVVuPcp+DTOddzOtY7TP70oMiPZPCB0tZrwPD1exmv3jr2dUtTA17NRKWnHR0KTsw
         +3S5Jl+fBgvtlyixkTCTwgbSXfoCMgVci2eyzyuWyhb8BhApPM0h7oROKNHzXYJ8UbqZ
         iHv/w7CDgUtWkV0qirWI1L5/tlQbqsfc6YT6ITSgCrOF7n8ooWk9YY6JboiYp8f9FtNI
         SERhjbWxv4yQl9r9r1EJ64jYW/ThFO+7R6GNaqipxso6iYz1UGMoo+06+9Qliqq65Mvh
         +NhUG7vgNzG5sgmuYepIbQNnwXpWUZ8U9LRPq92LbHrMyluySxvcZlbLWXCAITX/81ur
         SC1A==
X-Gm-Message-State: AOJu0YyGGRX+3iO8A/LDe+ftobTBW895J4mWSybsBilceyF0xfNjudAu
	arKC4+ZGut4WKyzCU4oVbEU80J5veARJZiifdkWd1nA1IqvtR5stpQrXxQ0i
X-Gm-Gg: ASbGncvKAFtqK/LmGBY+l9OjCzdapCOwxw9x0djQTEqZ+tawVaMrvU4cbBk4vsXt6io
	lYggp6HqGOEuwcEBzJNfYQ4FQ8CI8flcngUoVzCYA0XsUbZOj7OjI3DLVFzALou07awyLY8Lr2M
	BkCAREIrU79XfnxP9mYt8gJlvPhpqJ0Bukzrcplsb7768pBs5vYIzHf/xgg9bPIc0tc67s6ABk5
	fQApMP49kaScuOmCLH/qerEqUTFkc5tQXIWm3vy9kDO06BQCBIwxD4YtqGKE/vZAJT4rQRlOyo9
	zxDpX1YjyxqNqhjrsNRIGPbQYsU0fVTHA+ql/Eq+vGT1ty+g8uNhPF8M83s6pmDlQy2B2TTLcOT
	Jjp2k8zGKKGcEQ+65qpoQxmFNXBYeXixAyQ==
X-Google-Smtp-Source: AGHT+IGedn7bD97DdQBPhUuL4Z/rZyXGxuiF/g/i0tVQeb58rXRwgPlcA+GkGq0R52dy+mekauiv0g==
X-Received: by 2002:ae9:f402:0:b0:7e8:c99:96bd with SMTP id af79cd13be357-7e85891b8aemr353023785a.66.1754994463023;
        Tue, 12 Aug 2025 03:27:43 -0700 (PDT)
Received: from [127.0.0.1] ([20.49.13.179])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0874519bbsm97705371cf.29.2025.08.12.03.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 03:27:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1754987655.git.tanggeliang@kylinos.cn>
References: <cover.1754987655.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 0/2] mptcp: improve ADD_ADDR timeout
 handling
Message-ID: <23011bd2-a9bc-5a03-5495-f0f00d7658df@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Aug 2025 10:27:41 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): packetdrill_add_addr =
=F0=9F=94=B4
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/169040=
44239

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/9cc8618373f4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D990438


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
