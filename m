Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD21023505E
	for <mptcp@lists.linux.dev>; Thu, 23 Oct 2025 07:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206065; cv=none; b=rI6iKWAq4+keH40HiT0+ZhVZXISzDCPy7gxr6PV/XLZewZMc9D7HYGxXsdKVRiKHEGRXvEX1tgN3nu00CFolxx8ZwiybOhteHkKJ67SwITVnVTfDGBbXA6kHLwsNH1cVI0bXSQfsdkqzMQ2YovjyDduSKSgroRQ3qXTwpP/mINY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206065; c=relaxed/simple;
	bh=QubK99pLNNCza46C3AUpU/LQKCAYxoX6M5jeBkIA4dQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=e/gkPdr2jT6SQX7Yb2jiRC2QrVrwJPdubSav0pUPP/ofgSKHIAJ+rc/61PytzO3zbHhOIsW9vI4xAQKFZWm8urX4GVfQqOsRmuNnfpjgV+4wZ8UQ4XlXrYm8Qd1NxYPJrsgZQICmhIWe689//IMV3tSRsHZNeBlYoT8GRI8rYrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIAK9ueb; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIAK9ueb"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-78125ed4052so672774b3a.0
        for <mptcp@lists.linux.dev>; Thu, 23 Oct 2025 00:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761206063; x=1761810863; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GnV4IBExlCfFYd1mXiJjAM0HVqXKqo+cVO3n7i59zo=;
        b=lIAK9uebxV/sYZLBq1nlIZ8R959f/6b8r1Wof/oBCv+c9i3Lc6sRGV8UX6pIgCpnKr
         RzB1Ufb4tBdRWIF5/YOZkHrd2YWYI9JmZqYrHlK8AZnw4YvVWky8n9Z24Mhq5rbhVoFx
         m2feaAvHzv3mpNTv1SrUvN/TmS8VELnaZj5BRZqY5gBv0tWWNVDrDciurFp2Q5/fKhN5
         +smEvEKvH36DW8aufPB3df/C1EgFD99wdDEJGQtr7+OTt/fsROnEEOJmvOgbv+7WGF6l
         SfOK20PyA8MzUqE14s3wnk6yvGfKPEZaEJwlbAfi60S+CS3mkgODYDgRWGTv0Pc95/5D
         te9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761206063; x=1761810863;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0GnV4IBExlCfFYd1mXiJjAM0HVqXKqo+cVO3n7i59zo=;
        b=BphlRTl6VkLRwQyKk2FHsa0BSalKh95N3ao56oDr4H+L1C/JvbI/0f5KwI9W0Z3u4j
         WRyZa9qHTXVa/wReArbQbSafVBwIzR7088bzxdhBA8hd33DA92HXWg4M9srd+surLcP+
         oakBa4ls7uxIcKvFklddBptgyrChN3Cy5N5H1rZOBRmnVeMmzkz7Xk/o8CKisX7tdaOh
         L6T2HSkEg/3BI5mFT0wtEDmXqJGFEi/K6aSIO8KpBMhucThQ3iEvNi8r2YbjU/qVV+kD
         xryL2yFwhFMOt4tyimPeKW97ye1+9IAvRNZieWxV0/PSIF6kQ1ZVEmgE456u0Hbr54/1
         jQbQ==
X-Gm-Message-State: AOJu0YwNs6+saNDuxdZMpXktH5XeLzbuk8FZ+EKlZgUH7TF8HbnzINMl
	rok9XKAkCVtQo2N4Wt0P5aEo2/blJYbbugqNLsIox9zrX3jrGD1Ch6jL3t/Z
X-Gm-Gg: ASbGncvUpSV5Brxl2gE0/SqLBAjRclvB+308f+W7tRQnjEBP6beD18MeQC7OoQ+GaDi
	ZBTpKe+9OFaQSNJG66teeMnBw9th2F8rH9PebcqxcfIjQuvq9oyQJFe4xjfrxlP4Ivxek4WBnhU
	0YSYfo3dYIbw//mtonpiQr+vLFVIP8S9Wg7LaPpS7XYokPalt9AAqETnoDU6iC2ZK63nJVIVrwy
	FqNq6cpUiNfkhgM+ItoMTZ5kvR4QTs+P8DEDRMswYVq7rP+8hEIqwjD9Dgh8oucqXPi5JXjh7eK
	cScRIqw4W9LU0DwPHjZ+9xbq1b+jelc6moVT4Sw3YKMvjGjc0rjoBknO7S79Jwuzbhc/VD0zcpY
	NHzwEbO5TgSsCtY9eJcGY54wZuBFDW2Sj8d4YLgiKTkdVYsKUSV3QBdT7vg01n/0ScJjeXz+sVW
	yCBeGD+VJVab7HX+L24IIw5w==
X-Google-Smtp-Source: AGHT+IEp088uz+Hg62Bf8qtT06zid548W+CNzPjuUN4vpx6cXI9LcoJBjMLj/jTK91v1FskWA3Mkcg==
X-Received: by 2002:a05:6300:2408:b0:334:a23e:2dff with SMTP id adf61e73a8af0-334a858f4e4mr23417619637.25.1761206063132;
        Thu, 23 Oct 2025 00:54:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.161.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4bb9027sm1286087a12.6.2025.10.23.00.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 00:54:22 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1761198660.git.geliang@kernel.org>
References: <cover.1761198660.git.geliang@kernel.org>
Subject: Re: [PATCH mptcp-next v13 0/8] implement mptcp read_sock
Message-ID: <145cd444-b3d3-5372-0ce4-760268514c64@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Oct 2025 07:54:22 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/18739490600

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/4ea4f2c38c12
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1014823


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
