Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF32BA34
	for <mptcp@lists.linux.dev>; Tue,  7 Mar 2023 17:24:39 +0000 (UTC)
Received: by mail-il1-f176.google.com with SMTP id i19so278684ila.10
        for <mptcp@lists.linux.dev>; Tue, 07 Mar 2023 09:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678209878;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVmPAQTA/052aY92DxUdGi3I1aglR1yalkaPao5PT5U=;
        b=omWO6O3ELY906PxwcHB6C6I+8ZG62idKf+wbB5NUAPJg4q+h4w5FoNzVOLaDO0/rJF
         skB2e+D+Mh2yJk5QuwRRc2EXklTzJludebg+2pcwPXmUiOrxZv1jDg0OD9zz+I7c75N8
         e79ZB7f9cE3YNidKoiQkWVeq6DlUFS1D33Y18DDrzLPxOE3E7v9Wv9nCs98BuX2CoP3O
         XpVl7oPXLRKJeNa1FCFjwKk0XF4n6IYvDfIA3uVm6dyU4cj35USHPJwW9nxI+A9DWqsW
         hmXWqKizXXexKd/c2nASpx8jNdlNVMiXASBcemdfKyIGM2oOlNqS0DqEUWF6M2xCIeAh
         6T0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678209878;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RVmPAQTA/052aY92DxUdGi3I1aglR1yalkaPao5PT5U=;
        b=BZ9Ftum7cv8v2tXsZcrMZfmLji9o/T/GBt6s/o4nChoizBVb0B5GbQm+zBj70zoB5P
         JHuDp/slERO2DOoRsa647BeSmU0H1JzoBS9a6Hc9GdFE7FPZq6h/O/ibjDqYr1H+mrlV
         lRWsCRXtPeICJ4VH9YRcoFWm2ktLXtumv0FXTNWoqIt+/gx1brj8QyfAio4DHxvdIkjH
         Xfbvwf5KicvFBYHxq4NlpC/fAYY0HcqInoXSG+QlDZ1wTJHHnsR5rJug6KNfZ/EPI/ga
         1CHKk6yP3fQ7OTF5G3+Z7aKtU7RlrQCrBcsU4vpk/egTs1QiGZCxqd7K/tB04RsJhbZJ
         t9JQ==
X-Gm-Message-State: AO0yUKVABvN3LPs7uAsEgNgV/PSGxKDnZnBySXKY39AFkCt/Ira+rXJC
	rcEPOhRChjledUyTuDwRrWp7H+5KeZL9
X-Google-Smtp-Source: AK7set+2TYXoe3E1b2QaRrryIupsB59NrLMS8n+TZJSmxUtEWHHuawgM3vRWiqcW8iS8eZgh6WjQZg==
X-Received: by 2002:a05:6e02:1d8f:b0:317:c80f:b416 with SMTP id h15-20020a056e021d8f00b00317c80fb416mr13316534ila.20.1678209878077;
        Tue, 07 Mar 2023 09:24:38 -0800 (PST)
Received: from [127.0.0.1] ([40.77.92.112])
        by smtp.gmail.com with ESMTPSA id f16-20020a02a810000000b003bf35a3cc3bsm4341792jaj.85.2023.03.07.09.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 09:24:37 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ec8a2809ee4556d8b28efaef2aec26ce1a23ef4b.1678122760.git.pabeni@redhat.com>
References:
 <ec8a2809ee4556d8b28efaef2aec26ce1a23ef4b.1678122760.git.pabeni@redhat.com>
Subject: Re: mptcp: simplify subflow_syn_recv_sock(): Tests Results
Message-ID: <a3769ca6-dcd8-b0e9-7cc8-4abe1c94c572@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Mar 2023 17:24:36 +0000
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
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5946997224505344
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5946997224505344/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5384047271084032
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5384047271084032/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4680359829307392
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4680359829307392/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6509947177926656
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6509947177926656/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/b9f71868d34f


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
