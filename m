Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDB73205
	for <mptcp@lists.linux.dev>; Fri, 27 Jan 2023 16:16:48 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id 203so2301741pfx.6
        for <mptcp@lists.linux.dev>; Fri, 27 Jan 2023 08:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TA7BL2Sla1oWBFHPwSwlGxYthU877q5OGQTYYTjaZFc=;
        b=KA+FH/EQb/IWpm1Qm+ADJCVI8PCNOEVmsDWwU+NgI9Q/u1neVBduAONPOtZGomr/I8
         jdWBWcS2bapEW789nHhs0FDLgHYUyEgJvZwNudzJhXnzTKNfMeyOYcqrt+1wVJnFzwfF
         l+ohJ3p4QOM0wPkhSfyflDWF0hIawcqdrKxRInBb0EwPNrzom9lSUzQfzX4tjlsj3c1m
         csqgJzWav0xxvwdW7U98cN3PhFYnm0oyB4pljI7guKva94mVAum/UIgnUy/HepUPHVzR
         k0Uf8m+NhMl7J4s32eINZUlW2GloYZNUTwO0gTitWXgU5GtXSlQDAFaL9JHn4djk8mrx
         eiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TA7BL2Sla1oWBFHPwSwlGxYthU877q5OGQTYYTjaZFc=;
        b=hRU0Ung+0atD1Lu52ttgbcBCi/wIVofX6eKoYoaDfiGUrBuJN4EIdIiO0R50cIxnr5
         vECciveEbF8qAyOvz5yTqDbS7/dveWB/O6RfRSxKVXxbLVe+CU4VOekjl+gedNDPjc54
         J6gGPHLBKzzDzPENWNfV7Gpk+ijar8FQcgxHJeWMlwmUqYkNZ+lRhgd+ke07eQxR0l1H
         2tkJ/f0ZP6ytdJ7e4oebdqw69fqEFdNniAxjb7dEMX1KY8ARTS+TwmuSCmCPlCJLFF3Q
         vGBiF47Bj7PPl+yjjAnDqUd27VyKA1lfnA1gR6VnQAX5PrQz/cUYJO+2qZG4wK0FN3wy
         ZAFQ==
X-Gm-Message-State: AFqh2kohQnjZ60xdUPK2Bcs1koXL4N+2qkl3Zh7qHNLjjWeF1YV3yAd4
	EIanWNk6BhONBXGSiJTt9Fbaaa8qPQ==
X-Google-Smtp-Source: AMrXdXvo4aoBQR+2Cbhgvv+yKIqyD3Zh0Q0I3RbgPQDHC87P7vwgZNG0sZi4/migOPWW+n5ScbdOCg==
X-Received: by 2002:a62:6302:0:b0:582:848c:6281 with SMTP id x2-20020a626302000000b00582848c6281mr36196567pfb.2.1674836208387;
        Fri, 27 Jan 2023 08:16:48 -0800 (PST)
Received: from [127.0.0.1] ([138.91.227.51])
        by smtp.gmail.com with ESMTPSA id i19-20020aa787d3000000b0058de2c315e6sm1396995pfo.158.2023.01.27.08.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 08:16:47 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <4d5c94f133002e76ecb74c3303ab350df9175e90.1674767058.git.pabeni@redhat.com>
References:
 <4d5c94f133002e76ecb74c3303ab350df9175e90.1674767058.git.pabeni@redhat.com>
Subject: Re: selinux: Implement mptcp_add_subflow hook: Tests Results
Message-ID: <be0ae280-36d7-714b-01b7-9eb47fd88151@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Jan 2023 16:16:46 +0000
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
  - Unstable: 1 failed test(s): packetdrill_syscalls =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6095622034423808
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6095622034423808/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_syscalls =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5307859534086144
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5307859534086144/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5532672081002496
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5532672081002496/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4617878406692864
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4617878406692864/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7df2cba2e1f2


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
