Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E6623C2
	for <mptcp@lists.linux.dev>; Tue, 10 May 2022 06:48:23 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id h13so12058076qvh.0
        for <mptcp@lists.linux.dev>; Mon, 09 May 2022 23:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=qF3j61+gFBzGTwy807K9xze8xG8Bjwm3YojHZP1gpuk=;
        b=Md9oDGVwaf2kVe6dTestauZU3TqWGqaK7CJEQttH3LLsALMAGSRDZWHP12DSZhyqt3
         SRCzeiFsj4E0NX8X8xEBKb/7p99y/LNoOpEDqVZPr+gHT9ZM2ZxoG04rOHr/tzvELFP+
         fkqEIQ0Hp1RwASv4kKE5WEJsdMfVRWt8X3t3yLeayNm6uYaugXfDfPLaG28oDUAj7bla
         WkS2nIx8Axu1oJc30DndDDlyOZMmZb85vLyFE9R4B7jG1WGOTbQriyg36flp4ZKILcDs
         dRtcVmuVZXvgtzRIPMQOgOxe4aXDk+A/U8OZ648uq1Uj69OZ8ojAvmNUOAvOvWCg/8Ou
         LA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=qF3j61+gFBzGTwy807K9xze8xG8Bjwm3YojHZP1gpuk=;
        b=8B8hXsIP2RNkQyx2HglE5FMj3N+EQUvQKR9fOzoGZvEX+Tscum3mrwiWGCwW4QI6Pw
         tw7YkDaR40E2NBu2GrNnLnVralTfmJsbIlaPjRSQYfNet3gCiiKxvog5S7T8uuQae6nx
         xPq0hsvzRxTKqjxFE9hmB9RUq0YkY5uwrfCrUIc6oyoSR6xXpyq1PR+nTYN6Ri/veghm
         XK60TARA9Iw/mzJlU1c2vfkKmpjCrHfgENIq0EHUDYQ+8W8QjjcqKjJn7MbfLZPycsrS
         OKdW3c2B2VyUE7p7VHP0mwVdvXDNNsS8Gdu+7tEeGpVRbdevgWaHSFTzLsfGA+kK2H4N
         d/gA==
X-Gm-Message-State: AOAM532u6xCp19MSwN35eFvfv80/uPH1g1BKVJOl11vwb7IM45bvEJ3H
	BXB359U9zW3xIpSdO4a6/GJG+kluVw==
X-Google-Smtp-Source: ABdhPJxP9DZZiDjQ5hO2cs5qY2lD/9dyNLsOLzAB8hDw0OEn6wE0tqxifdCPeG5I69d4k1TeNrgPOQ==
X-Received: by 2002:a05:6214:d8d:b0:45a:fbe2:e7c with SMTP id e13-20020a0562140d8d00b0045afbe20e7cmr12157042qve.48.1652165302769;
        Mon, 09 May 2022 23:48:22 -0700 (PDT)
Received: from [127.0.0.1] ([20.246.113.167])
        by smtp.gmail.com with ESMTPSA id bc3-20020a05622a1cc300b002f3d52d57bcsm4422181qtb.26.2022.05.09.23.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 23:48:22 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <173d7544cdc6bf773f6e84cf64a53583db6df634.1652156553.git.geliang.tang@suse.com>
References:
 <173d7544cdc6bf773f6e84cf64a53583db6df634.1652156553.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_add_?=
 =?UTF-8?Q?bpf=5Ffirst_scheduler=22=3A_Tests_Result?= =?UTF-8?Q?s?=
Message-ID: <f66c2b02-f9a4-5b45-4bcf-5592c0140780@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 May 2022 06:48:20 +0000
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
https://cirrus-ci.com/task/5511172811128832
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5511172811128832/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 3 failed test(s): =
packetdrill_add_addr selftest_diag selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5055882319888384
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5055882319888384/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c6fbed8a275d


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
