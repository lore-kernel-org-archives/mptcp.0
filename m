Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457463C0B
	for <mptcp@lists.linux.dev>; Sat, 28 Jan 2023 09:40:34 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id i9so6135460oif.4
        for <mptcp@lists.linux.dev>; Sat, 28 Jan 2023 01:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57c/jMamwvkTfo1oNKqd76JBWf9kT/OoaCe8X2HwldI=;
        b=kVGWEDhp/zvidmvJvzbBBrQMXcejIrBLjIigrU2gEHViSe+hMaPb+wX0ea7JyqwOmd
         NMxJXS66f8LbsKIJmh/wemhJIrfwBK1sJAUtrR8mlpRBZQbL6XoQqDpWMyC6KyqZBbI6
         5NoRFJSV+N7RPl42mfv1y6iuBYvZx6jTb98BaklYBM1qV8ePxObRaFp0TtvMBaTN0ViA
         Rl9EfQ9kn+CZoaMVt0CpfaA4rrQ/+AOWcDV8YNQZcKTxLLyHD09RXHklWns56L/B9SeO
         DWLGnjnEH0A/94/FG73bTEoChXc+aSQkZRhWWmOfIYxkFl9if0QWUb9fIc3YbmBmFO2m
         8q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=57c/jMamwvkTfo1oNKqd76JBWf9kT/OoaCe8X2HwldI=;
        b=o1x6V7F4v6Rrd/YURcgyGG5P7PNmlDONmfYNwJlPDCerslGXtZGJYDuY5hiGWAKrEs
         tS4wVzMPeL+rrdEx8z7JFYuEIR/i0WjnegfH881pnvCDacOdUXVINTLuE9QIqrCu9L5v
         qCkWD6rmSpuA3diB3WPheFLmnMyzTcpHJ7/ptB2Mfhf+gAEgMHYg2d7oCpZ3tEHRD46x
         imfxnCuuVGYkdCjb8wKMjP+zC7kdUU69GUZ0MH6Ieca6qgUxv5eFl/zRLZO4NcA5VKhL
         vr3exaO3KgnB8eUWbSRz5v8z30b8Tor4MvNydDYus9CtQKqFHxQnYhJSRcir8N6Yezxv
         A1aw==
X-Gm-Message-State: AFqh2kpvYYD3e6vo1ygOA+qn0xPimckfPWbzur+C/eg85JplijWVqZnn
	rOY1Z7ohFIjuturJ3O1SpQ==
X-Google-Smtp-Source: AMrXdXsRNnXfiHQ3MwajyFfYhY7uK8G5h0e557PcAB0/UEzVOgywJq94nAhvJAxaI2eV6g3ZUupsOg==
X-Received: by 2002:a05:6808:b11:b0:366:bfc8:ceaa with SMTP id s17-20020a0568080b1100b00366bfc8ceaamr18736790oij.19.1674898833199;
        Sat, 28 Jan 2023 01:40:33 -0800 (PST)
Received: from [127.0.0.1] ([40.84.170.96])
        by smtp.gmail.com with ESMTPSA id a23-20020aca1a17000000b003780facc45esm245414oia.50.2023.01.28.01.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 01:40:32 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d2091b4407a0d54f561f44fcc438555454d9fb47.1674844826.git.pabeni@redhat.com>
References:
 <d2091b4407a0d54f561f44fcc438555454d9fb47.1674844826.git.pabeni@redhat.com>
Subject: Re: mptcp: be careful on subflow status propagation on errors:
 Tests Results
Message-ID: <fd916608-0fbd-adae-9e1e-57fcc55ee124@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Jan 2023 09:40:31 +0000
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
com/task/4931194693877760
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4931194693877760/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5494144647299072
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5494144647299072/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6057094600720384
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6057094600720384/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6620044554141696
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6620044554141696/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2ff04d64c688


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
