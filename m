Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E20747B
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOe+L0TK"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6ce322b62aeso1774171a34.3
        for <mptcp@lists.linux.dev>; Sat, 04 Nov 2023 08:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699111898; x=1699716698; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuO14DzuYd4hi9j3LB1NcxMzNRT5UHoPo/+bcnpuJmw=;
        b=cOe+L0TK/GsIc/BDnNLkUOWJebnm3cay0Ikohcd55kvDvOhgvvodKzX2HF3VJfWQur
         G1zF8LqdhlRslV8WeT8EWw0WMXKsTdfd7vptyGqVk9LI9NKDhHHm3kOE98UiIYVhJTHF
         wyO89RMlG3hiXkLNSNqOO5JdDWtIhfvIE1Jagkeh+yXknRDsQdqobdRSNvFOojrZE7Wx
         Gc0yjwJWFznlTYv6wjnbNg1Q+H7q6DN/XF1tu1SznND2isi8DO/qyP1aMkqO50wxcRdM
         hurWFf4s9ZymtDwuGQIfp2f0KWZB18djzLv42TjKaU567X+C9BewMYOe9kWqf3Y/Dymb
         LKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699111898; x=1699716698;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XuO14DzuYd4hi9j3LB1NcxMzNRT5UHoPo/+bcnpuJmw=;
        b=R59AiwYFHok0uCHw9Q+nNx/dYwizgN/V4/VT4aVapsxbAAVkHLS5NKu6Q7pg+cDAEO
         iRDXYr+7Z3bn97VNP0Re1y8P6ejxZ4rs9kW0le6Zhpx3HfqvPiHZoobb+UDM9QQbj57u
         clJI66nuQINr4nNRJyulj/E/K5z5tdXwL0jkVvdYlBWT33xqoZnNdZzaDdR/eHENL1ca
         HRzNDYUHsg72sFhTzKuDhheiNcv2TtO67v3zBCsB6eqBu3O9gGNB+L2qLmWw/fW9VVRV
         AmmVf8odjUyI2OJWAXmqc1gy5NWl6B+bn+JACMFt/BhybwLs1MCrBQaIgehqhKUs81kd
         /Ldw==
X-Gm-Message-State: AOJu0Ywg3Pc/m2zGzxNy7HWfeL7ocuIdDBn2usUZlv0CJkjqlPs5w5HO
	gKenuWxNCnYnToB7Ey3OBLAnIjuv5g==
X-Google-Smtp-Source: AGHT+IGk58YvfQjmBp1fNsfEdoilRIEIY0GDoUsx/KYx/2DNdlpBLS6wKkgNODVlIeA4WC4asAr7hA==
X-Received: by 2002:a05:6830:3103:b0:6c6:18c7:7ca2 with SMTP id b3-20020a056830310300b006c618c77ca2mr28358102ots.12.1699111898296;
        Sat, 04 Nov 2023 08:31:38 -0700 (PDT)
Received: from [127.0.0.1] ([52.226.113.40])
        by smtp.gmail.com with ESMTPSA id g12-20020ac84b6c000000b004033c3948f9sm1706622qts.42.2023.11.04.08.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 08:31:37 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <fdfc8e7f6db275ccdf6f9fd615baf636f01baf93.1699107275.git.geliang.tang@suse.com>
References:
 <fdfc8e7f6db275ccdf6f9fd615baf636f01baf93.1699107275.git.geliang.tang@suse.com>
Subject: Re: mptcp: drop lookup_by_id parameter in lookup_addr: Tests
 Results
Message-ID: <7fbfac73-4919-ddf0-3fca-a8c234611e31@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Nov 2023 15:31:37 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5918424338006016
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5918424338006016/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5355474384584704
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5355474384584704/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6481374291427328
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6481374291427328/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4651786942808064
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4651786942808064/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2d3b6dc8ee02


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
Bot operated by Matthieu Baerts =
(Tessares)
