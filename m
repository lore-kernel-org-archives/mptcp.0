Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AC91306E
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 18:46:09 +0000 (UTC)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-777a6ebb542so198513139f.0
        for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 11:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687891569; x=1690483569;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiUHGDKO3rSwCIoz9FhKo36lc/h9mHEXR7SgmIs9Qes=;
        b=pV7fM25NDezVA6PwWwvstXXnSXOJdAjEeZcgovnn+FrsALn5qRDwPSsLV+cQYBQ139
         6qAV3mDSYko2KWAm/JzvvjjtaOUniLncmtosinfyvoFtpUq8oJQWeUClp+gNH+qRoH0j
         yXO4a7lGjSjiox6mC7dMbduRfRz+3hW+wzsmO7NmSEOX+Gp/1DSc8HJaPn4tS0BkE444
         OnxrVSVHr1VvUVVCU1QUs3lrbh+JAEdF2PcRtctKKQ6m0vW6fkxIvV+0tJ0KCjl5vgP4
         Pm9Hqv8cJ602XbvbuV2MmLbjjqR6KIBxXkCZ9U57/TmZCMRdt5gd2xxHJgjuqvZiOFrq
         RGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687891569; x=1690483569;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QiUHGDKO3rSwCIoz9FhKo36lc/h9mHEXR7SgmIs9Qes=;
        b=kzk6g/rK0ZJo0pkoMqooKig8w4/ya8Z3CagsYoQjYYZTteGqWeheLEfykuIF59G0Gh
         wnmyjVlpk3+r6t9k6vrbACahtAcyCgYFosN6A42YlBdaPQ0w4WkepFCgHCPd/cZ9DRTB
         odfc9WerHHHxEfu6XondWoQcVacFk4m057exLjxqENw4YrnVvDuf+Anz5UWbDmTg1+VC
         b8swW0EN5Qm1uTBlBN+Yl1/fOk1EDycG0zLcqQrxUnRJ1vifqEG56dcU8jT1wOOiZQ3j
         loasf8zvICQtBkfhXBw9NdWsBBkaE+WHLLjnXQ0rjDWbNO8eFUvnNz9x8I25MOgiy+wR
         U17g==
X-Gm-Message-State: AC+VfDw+1CSqauhZwmOPOO9zRLIGRcGYFZyTBv6tbgeiwHF/TrkovQZD
	Kk6TbMml36NrBiVFGsc3xg==
X-Google-Smtp-Source: ACHHUZ6pmCnLbvBpn2KKqNPKZYI++dPSEK67nh1esvDcI8iN0kKFUbZaN034qwtsmhA1DQzubkbSEQ==
X-Received: by 2002:a5d:9452:0:b0:783:7275:9c47 with SMTP id x18-20020a5d9452000000b0078372759c47mr2976778ior.7.1687891568764;
        Tue, 27 Jun 2023 11:46:08 -0700 (PDT)
Received: from [127.0.0.1] ([40.77.92.221])
        by smtp.gmail.com with ESMTPSA id d25-20020a6b6819000000b00777b94e8efasm931751ioc.18.2023.06.27.11.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 11:46:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <4e3c5d0b8d30cd8aa36ba591be38e5ca8958edf9.1687886219.git.pabeni@redhat.com>
References:
 <4e3c5d0b8d30cd8aa36ba591be38e5ca8958edf9.1687886219.git.pabeni@redhat.com>
Subject: Re: mptcp: fix bogus socket state update: Tests Results
Message-ID: <08e7a375-af0d-b512-0a64-3a8489d72a76@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Jun 2023 18:46:07 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 2 failed test(s): mptcp_connect_mmap selftest_mptcp_connect =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6484223167561728
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6484223167561728/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4654635818942464
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4654635818942464/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 2 failed test(s): mptcp_connect_mmap selftest_mptcp_connect =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5780535725785088
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5780535725785088/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5217585772363776
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5217585772363776/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0b63ed608b76


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
