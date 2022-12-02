Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684DE29A0
	for <mptcp@lists.linux.dev>; Fri,  2 Dec 2022 14:36:13 +0000 (UTC)
Received: by mail-qt1-f170.google.com with SMTP id cg5so5302605qtb.12
        for <mptcp@lists.linux.dev>; Fri, 02 Dec 2022 06:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zs2Gs0jko/0Ar4Z7er3ktGoOa84bMEbml6tUIKpkUI=;
        b=GA54z2mrAoic/DvnjqBXt7Fzizovb2AlJg/sbU9UuKaYl8Xsf2NUrXkhbNFjMhh5dt
         OoZkElRLPArBV6u7xxgqQ610/g5XyGiSLt1BA5zjCcF3msEVPnwS7fWU2yhEDCDRpdc6
         SXg6s4UfGEag0KRZ7W7BAXHUqc7aZjiRN4JWMkIzbeeGLVXAHSk740CQR6SwcyGM0sVn
         V+573+eYg8JZY2Brnq8xySqbUYYfX3Oldgs2vLFN4EZfqjJVmgIZdk6gqtjxhoVi4884
         ZUlbCTJNfy+HGLZZ0ptqH6mVVXwjqzPeJbIc53j9d4wrnBcULT8nCm0mO5Cy4o9GKxvx
         tIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/zs2Gs0jko/0Ar4Z7er3ktGoOa84bMEbml6tUIKpkUI=;
        b=2Rn0p4rHECkeuWE9ZEQAtzJ7gkRgA7CDFi1zMTTvYdROm1+2mha4lX42r6FH22or1/
         34AbtpwHQbR45vzS079UWQ8x1sG2CjR/mxHNSRbgot8TVPq2WwJBRVeAn31DxcnwaRlm
         Z//w5qYHzU3uuqPvTNU2viiK62SCJLzTuiO/zfnRmRRsQQMLZaz7ciJVBe+K4ecnFDpf
         wKMKex0Qs5M0oTydRfnZRlPiT/5aoEbh1OrQADEs5KlIzY6/SXJU2xu1RWZDDfit5Sgq
         /t1BhhcA6PvLSOIhOAXXp8ZvGWMaSqHWqDb8JN5JX6jJ9y98p64ibYg8st0Fx9evM2+S
         aIhA==
X-Gm-Message-State: ANoB5pneVEPPqoaB56ggAs2q8YLfeXC26kAyC8H3mDDcqJH6R2HzXAWf
	roqAKNYx2IjatxSS0KFoQg==
X-Google-Smtp-Source: AA0mqf4gAFm6FipD23gx6nPlpsEySKmZf0in4EccmLxehnzoxFE1EuWwkG4c+L4E+zA8fGDbz3L8zA==
X-Received: by 2002:ac8:110c:0:b0:3a4:f665:3619 with SMTP id c12-20020ac8110c000000b003a4f6653619mr66706009qtj.669.1669991772271;
        Fri, 02 Dec 2022 06:36:12 -0800 (PST)
Received: from [127.0.0.1] ([20.169.238.199])
        by smtp.gmail.com with ESMTPSA id w3-20020ac87183000000b0039cd4d87aacsm4194736qto.15.2022.12.02.06.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 06:36:11 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <409d2e76d1dd4e35f99e0d38083fbc2a64406859.1669987293.git.geliang.tang@suse.com>
References:
 <409d2e76d1dd4e35f99e0d38083fbc2a64406859.1669987293.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_red test: Tests Results
Message-ID: <cb631317-5406-c1ba-4077-ab1d98459e55@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Dec 2022 14:36:11 +0000
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
com/task/4751096581718016
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4751096581718016/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5876996488560640
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5876996488560640/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/5314046535139328
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5314046535139328/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6439946441981952
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6439946441981952/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c9b94d2472b1


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
