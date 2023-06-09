Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7E31B904
	for <mptcp@lists.linux.dev>; Fri,  9 Jun 2023 17:06:10 +0000 (UTC)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-75d518f6f74so175448885a.1
        for <mptcp@lists.linux.dev>; Fri, 09 Jun 2023 10:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686330369; x=1688922369;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSn4qYn3etx1UdrC0hNHw6g7VevzIf804qd/m+uclIk=;
        b=Kgm0J0q6uypMd+nlwBVxWzO45QwlOlN1oj8em88LEtzQajNQcE2FK3XL3x6//E1jfV
         NpkSEpo2jI4OlGad5QIJodUgGcqjRaFL8Pn/XhUfnUXPS/Ri5SjsJBJkud7VUWCAOJEw
         QMlcRY9wRCIW418zmw1Ikde9ILOpl3qWH6EDtEJRjOnnZqTMe+4k6cyDvOZjqDoUVyzz
         derklkb+lF7m/jSn6cdRagQ8AkUAAZ5kv0Vza0uBKFekCXVG8tY4bK6rwFO9vfkbzM77
         axORVW0CWh1u500VZ/qhGT3soqHm3nvV4DEqKi6Y3uHl1dakHjvzN9qCzuoW3mbrx9s2
         0xXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686330369; x=1688922369;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KSn4qYn3etx1UdrC0hNHw6g7VevzIf804qd/m+uclIk=;
        b=ANgQHgnpcL44jEulRLkHH5gXEA6AgKYWyVOzKqQ2PNBy4DYcXbImGTDMnjPx3umVBe
         jaL5dOvnZTa9xWX6hYBdOgY5xEv3RItmyFud/f9/CJDgUGJu1vrrEens4qMHKVpxR5r4
         U7OGrJKu3fgTSqaGKvNuCrYwyOAWz+XZXZng3xbfqlLqSF7ADmX/j6TqIvyaS51+L3HC
         0iLkf8WdTTLBSPZPbF0u8THtswEv1iS4sTcLdDsQoizV+DGW+tunztrBxldWS4mzUnnY
         4qdPKk73WgcKm1R4PiLg3f02BB0Au1wn68F2imtiTlo2GoiBxANqebkBMrWQ64EVHmum
         cX8Q==
X-Gm-Message-State: AC+VfDyyGA0eYN/YLG2N15fmr585AiFTCacON63Gb8O5Nz5rCQ3U69GP
	vqj5R4gQwspZ0UO+ucCI6bJPa8d5jkUX
X-Google-Smtp-Source: ACHHUZ4u/GRp/7wo3lnQWCmGMnGqMKgWXdAWCM9/1h60SiphMok2fnI7FK3dCKzgP52eflZk6UbEzg==
X-Received: by 2002:a05:620a:1a1c:b0:75b:23a1:8314 with SMTP id bk28-20020a05620a1a1c00b0075b23a18314mr2228956qkb.15.1686330368985;
        Fri, 09 Jun 2023 10:06:08 -0700 (PDT)
Received: from [127.0.0.1] ([104.45.204.83])
        by smtp.gmail.com with ESMTPSA id c24-20020ae9e218000000b0074df2ac52f8sm1162838qkc.21.2023.06.09.10.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 10:06:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <c399069680ffbe40604e1227aba47779ef7b030d.1686324786.git.dcaratti@redhat.com>
References:
 <c399069680ffbe40604e1227aba47779ef7b030d.1686324786.git.dcaratti@redhat.com>
Subject: Re: mptcp: convert netlink from small_ops to ops: Tests Results
Message-ID: <16d204ca-3a73-b5da-61a4-7a93e9f6b35a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Jun 2023 17:06:08 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Davide,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_userspace_pm =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5973662822563840
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5973662822563840/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4924067506028544
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4924067506028544/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_userspace_pm =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6536612775985152
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6536612775985152/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4707025427365888
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4707025427365888/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/f7bd261a395f


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
Bot operated by Matthieu Baerts (Tessares)
