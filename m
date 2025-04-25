Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D1B2522B8
	for <mptcp@lists.linux.dev>; Fri, 25 Apr 2025 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745585753; cv=none; b=jL0QkUWOQsafuuEKQyuNvpShCEm2k+PJRQTbMOOwQPh37DS+rQPFTlcQZcnSXliKEK4QDPOIaLan5sSDCw1Zrg0D6xDao28fhDuuekswan7EoSwPTx8WxOzXeXLEFh9820WWZ1rM2n/AOhWWwn8giQ7Iso+ZPohr1SSrfX1Tk7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745585753; c=relaxed/simple;
	bh=F9t+2MfJr+QtcMml7ASsMKF0LIXxwoGhtsqK7YA5miY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=q+HE/v9PVxL3g94UN6LBBJJ0mE8sKKi1582k6+6sA0idwMI9aSCaof9ns1Ua9ld8rclV+/DsJCrkV8Ma1FgnXddmfcfcKw1kyQ1KCQ3U4JLMzYpV70otm6pJj9L+c0jLCEVmcA8Z96qXpzvSTnLRD2EXv6EdaSBe4RJauaMNGNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvzqYLlR; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvzqYLlR"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c55b53a459so250049685a.3
        for <mptcp@lists.linux.dev>; Fri, 25 Apr 2025 05:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745585751; x=1746190551; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPdSIQeW+UR2hYjg1XGwYDpSMJ4lZ6h17ypIKv4f5G4=;
        b=gvzqYLlRzYoP5ago75T19wOzPrFjbuORCd3OOIX6aJGHXavkbNd6nu+kbPKseTTbrI
         rOofz575V9D77vhb+Iab7/W2mr1/ocukegHTN0PBq1XffzYRgJcGDPB79QqMxlF9QI9J
         qXORSb07M17oNX2GWGAboCcx5i4ssXL37eLpya8Eks3xOwY0i6PNBxxHts6s5radR3Or
         892VwFu6G6rpk9gqCix+pq3qoWp85XJcPMqCGl5BsdonvR0LKVEqrYEISfrj3fr3p5aV
         qM8JpExXuywxE8ZpdROeql/w235lFQ7p8XUNc+eKaukEgHY846EPVXyjdkZJC34JKCbW
         2s7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745585751; x=1746190551;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IPdSIQeW+UR2hYjg1XGwYDpSMJ4lZ6h17ypIKv4f5G4=;
        b=ClQEUvaMSBnNGkQL7lepaeciMVRqp1MEWGytXCjkDUHu9RaURj7JSkh9eS1PTNjHEj
         OM46iIr+82O94kDE+dItl6O5/i32Cv/zE+B3Q6p/43BZjU05mjdI4s4VYF2fx4PwqmHe
         ywB/t1MmqksBgYtrkMI2wL1E+Dqe8p7y6YD3DFKHOkOcdCwh1Zzn3ZfgG3bbNmQrQdQY
         lOUOUNXeMbzAzopu+VNN2C47a8WjFHZgZQo3gTINAQirxYpQn5kk6UCN2TFtHrZ2u2FI
         XumYtYXDQrUZ520pfu1pyE0zm6Z//jNLBBbW36cT840Yb2lZunTpHm9wGW0JrWS5PKB9
         Po7g==
X-Gm-Message-State: AOJu0YwfKRcZA3p+OPg2ze6ulBVBP481eqiSWPCdn6U6nqB99N6zPYRF
	Exl5HDYJM0Eqnbk6RneQafPKXiRvj7XAT92dItirHdcG9uJUk844XEJN
X-Gm-Gg: ASbGncvdQyy2pW+QhlPI17PD22yctgsiOkOgWsHGx818pys7Bdipc+uW6iH9hQKtxXF
	sUaM7YMj7ZXM1raoJlW3rhChDo8YRlNw1BPkZBA2ZJ2rq/ldFzAmEliyMw8d7ToGM1mzcS4a6sU
	94Wdrzb4KDflkgzX1JmOEYTc271vlaoENO3Q+MnHvsMZJvqDI16Qx57zGGcP/qI7PdMn3G2Okfa
	nW+w2UbUdPEvcSvJnexvmGwtNEM6AC+sAjLDrvsfVhRP8GHej7ZoVTEYLeQj5vc7xP/bgpNfChb
	eOxOlSPS59uf30bI/LFYkcxzPC3KBXpbiS0TsTS2T25SznpJDFumD2hkfT6oYQ==
X-Google-Smtp-Source: AGHT+IHsl/mW0jIAazqQd08ZOVRC4+LBVVZGsvetrXRn/frO2EXWas1p6wtd+ERcaL90+SDJay//xQ==
X-Received: by 2002:a05:620a:438e:b0:7c9:555c:f689 with SMTP id af79cd13be357-7c96069b9f3mr360185185a.11.1745585750988;
        Fri, 25 Apr 2025 05:55:50 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.46.35])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958ce3d54sm216320385a.51.2025.04.25.05.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 05:55:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1745395366.git.yangang@kylinos.cn>
References: <cover.1745395366.git.yangang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/5] Add 'dump_subflow' test in selftests
Message-ID: <49c8231b-ada0-1a89-77d3-2ea4f9c054d1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Apr 2025 12:55:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/14663915269

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0a861e272da4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D956852


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
