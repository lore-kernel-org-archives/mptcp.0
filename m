Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343821B93
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 09:58:00 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id e6-20020a17090a77c600b001c795ee41e9so4029116pjs.4
        for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 02:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=WrkJ2S3mNuHOKGx6v3XENw7Yk+MF7htIGVsLkAObT2A=;
        b=MK5FDscOZWkIiwhWH2Gi00E+rfANmIv397ZtwyW/Z4wq/Ax5F4H9nMkG05vX1dLcvP
         CEGCZD/yFIIIUX54/AxjUrq3U+HUV2ayIjyNGWs0nHaueg7ImxAMYeahz10Sk7RIY8FC
         1dxqCndB5KxDDMojxFRykeT+AsNO3IRZFf5f+ky926ASrtHllyjgHdXl3u9JuY22p8IV
         xMyWNrVz/JcFAdRF46AYPulTv0EMWuRMRntR7A2AZ6CkvWIznoyjjiAfrXylV4PpgPFj
         xV5ckfXGt75BM7SGy+I7e/wDPJUl4kWFzjWg4Sqa8yhuZfvMpIvcbDUwpkFmh/yz5TBe
         OXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=WrkJ2S3mNuHOKGx6v3XENw7Yk+MF7htIGVsLkAObT2A=;
        b=y0s3Zb4g0lqr2HBhU+DnT5MKv+nlEhlBPm2ADzvBe3BZOrQivdshUaAG5aOjTeo5ts
         nniF95DXZASEyGeXYQpnjWvywIJEN6zJW5fwU4772HqxxFMrtdwmm6V9gKpKu+hkErg+
         tQNT1JJxMEAuU/Y+aPRu7Vh5pKLoobW4LZhsYAPBrbFSgwRmLY8iWIxs5SvyG2vT9mCq
         DVvARh1vhjmKRCDwGksJVCU4rdoOJPF7DbLpUV2bb4iSa5hOiz8vyFeIilOjI7ZzvSHc
         raG/XFC5narnLwoudQmntZ3QvR2yFqDZTScVH6n3Tb6xHsJlDLX1Vyusb9yUdyVW6pXd
         JSMA==
X-Gm-Message-State: AOAM53114s9PmYarZ37VOxaavhTlo8xv6mbV0EtW2+Uq42W3omAlCGEO
	bbZTzlBPKM0HnUx4A9p8QQ==
X-Google-Smtp-Source: ABdhPJyqvKiqtmQEjgns8bC3rZDrtlXTbLfXxga+cnewc7GUshfMAK4WTLfdMaa09YS5cmYKSdf7Sw==
X-Received: by 2002:a17:902:6b47:b0:150:80de:5d49 with SMTP id g7-20020a1709026b4700b0015080de5d49mr4901768plt.77.1648115879511;
        Thu, 24 Mar 2022 02:57:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.88.154.156])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a000a8200b004f1111c66afsm3243231pfl.148.2022.03.24.02.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 02:57:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ce54617746b7ed5e9ba3b844e55e74cb8a60e0b5.1648110794.git.geliang.tang@suse.com>
References:
 <ce54617746b7ed5e9ba3b844e55e74cb8a60e0b5.1648110794.git.geliang.tang@suse.com>
Subject: Re: bpf: Sync comments for bpf_get_stack: Tests Results
Message-ID: <7c00a671-e4b2-3669-736e-9919118f7f85@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Mar 2022 09:57:56 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5371691516821504
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5371691516821504/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6497591423664128
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6497591423664128/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b02f75e52950

Please note that despite all the efforts that have been already done to =
have a
stable tests suite when executed on a public CI like here, it is =
possible some
reported issues are not due to your modifications. Still, do =
not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (Tessares)
