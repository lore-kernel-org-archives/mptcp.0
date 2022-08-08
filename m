Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A34D1FD0
	for <mptcp@lists.linux.dev>; Mon,  8 Aug 2022 03:18:35 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id mk9so5552260qvb.11
        for <mptcp@lists.linux.dev>; Sun, 07 Aug 2022 20:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=DlOE1m330s6OjZ+B6xlWpdVreasPXj9pYdhyyojHzbE=;
        b=OSKHXguyPykhrZwau1YNiMEupLYk0L9Lm3VaWpx8VlPvu4zGTmRP2lDY6OZFyda4dY
         XxC7K/7+zmN1H4MDxa/DlWvJ3+f2tzkfSCbng1cbrWF2nea1/ofV+AFSTZWcxg96NSe5
         QTNCrUj6nT49obU7oZtPeCG2ANuLUgNnn+yP1sIkrFUoUN2sPJ3WmVw4XKAgCcAuVZ/G
         OCaF33aRMmNtdAkDR8JoJjxvJfK5vcrspoau4a7Px34LitrW8K9seuJ3xBg1BzQQyUkV
         8xefp4jZhWIJqH+L1ucXd7JpqP4e0wwHvAMuZn2UpcZ89u8eymf+FVjbSTT8c+aisKeq
         o67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=DlOE1m330s6OjZ+B6xlWpdVreasPXj9pYdhyyojHzbE=;
        b=F45Wv5+dChqj1nWOa5iASBknxdCu9AXJMkW+iHti2qcWf/0HMgYGFhOVytwgSFkIdz
         6rx1thOFCiPD3yTL9ZFJT+dTX351rww/OXiwkvMuFnsOP52sTkQa1aMp36qH02R1KU+A
         Ol5pltH68gghO9c8wnK1bQV4XzA4gauCImSrokckvlw1nx1LRo3SIfpkS1V8oMJeEIna
         acb5yJTtvoLtpeYjeJXkWdjSkLVJTihWRnG1TE1/Zcu7PT8lq9pnYCcRfgbaXviyY8QO
         BgFoY6RPpw4Rv3tGCler13qzjbytflsHBbhICzqLZNSxMt641Mp24KGhxLJvgEG2AOIs
         6xVg==
X-Gm-Message-State: ACgBeo1hV5Ui7NMOzVPqgp3OOJeL7g1qQZXFsv3P48Jy+M6vGoku0OPO
	CXXkEY7i3+olo2wI3N8M16pqYA/p4nOO
X-Google-Smtp-Source: AA6agR7aPSWXtFGVOYOmK7wjD9joyXDLIgCVD3CEsLCnMMr0VUdPh71oCnj0efzqvFGPET3G4G1Tig==
X-Received: by 2002:ad4:5b8d:0:b0:47b:2c2c:96f with SMTP id 13-20020ad45b8d000000b0047b2c2c096fmr6274698qvp.80.1659928714367;
        Sun, 07 Aug 2022 20:18:34 -0700 (PDT)
Received: from [127.0.0.1] ([20.98.227.125])
        by smtp.gmail.com with ESMTPSA id g3-20020a05620a40c300b006b919c6749esm6767023qko.91.2022.08.07.20.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 20:18:33 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <a13144785eab9f2568fdf9eb7da6714d4a911756.1659923077.git.geliang.tang@suse.com>
References:
 <a13144785eab9f2568fdf9eb7da6714d4a911756.1659923077.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: move prefix tests of addr_nr_ns2 together:
 Tests Results
Message-ID: <52c7a0d9-e198-d975-8536-376941e335be@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Aug 2022 03:18:33 +0000
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
  - Unstable: 3 failed test(s): =
packetdrill_add_addr selftest_mptcp_join selftest_simult_flows =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5800980959723520
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5800980959723520/su=
mmary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s):=
 packetdrill_add_addr selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5238031006302208
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5238031006302208/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/35a5cdc0a810


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
