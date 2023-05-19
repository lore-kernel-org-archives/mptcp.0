Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1447A10961
	for <mptcp@lists.linux.dev>; Fri, 19 May 2023 15:25:36 +0000 (UTC)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-54f846d24d1so942131eaf.3
        for <mptcp@lists.linux.dev>; Fri, 19 May 2023 08:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684509935; x=1687101935;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8A1zCw4JL0PbGDT+kw0IrMG3jN57xYKljgYBO3qCtXk=;
        b=h/FhWqvGZh6bgFSY8CYI7h8IPxKacPJmtd7wp9RWAZ43bLEf2eek9o+VmMZjZnPkkE
         pmtCC1naN42bKHT3jgZGP4CLKDUV4WrIJ9Xu/6h4515J2FWiPFgad8NwdOCdWWm+jZsd
         yW1n4sfwQSaicq/7rxbEgVYI2kwt7ACRZNSIJECHJW+pGMizimVNIW9cPeu6m3DczLWW
         1rVHOcff6uDFVjgdy3BPRiXrXpHT+n18QcYkvVUgdcxllRkpmjaZelAUSxitNZisPLN5
         z2uMO1i4ZxHROrmqqzYepxis2yiygMpAGni3jJHFsU9xU4tz5HR67nZs6/g1VpHw2IDG
         O6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684509935; x=1687101935;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8A1zCw4JL0PbGDT+kw0IrMG3jN57xYKljgYBO3qCtXk=;
        b=Xa/ap0siVbP3cDJKtyt9l+8Sjxt9THWIgwS6cKf3+9PF7GsFkrnAF+4YA9l0zarRoW
         GGYO+ug4puL7gcXdmHEHYMSLO66aq7eBsHybzJNXy5vKCTm6WObn20ej0EbhE0Ui/VSB
         qjJMS+32VAG2BqAsK4i/xZsW7rcseYZV+4hQU8GYbLucJqi2Oj9w/B/qg3pz5cu5x/l3
         4bd+ZXUzCNqHbvXhQFg5sSYnGiCvpTH9bjywawM780ocdUFqCVKrgWE5mSIyJFQGx9wR
         nFCALcrYILuF4ahKvI/Yk5OM19ci4BtktCpE/jOkCmJ4nuERdACJVKb8vhrwk9JyKvix
         I7Ng==
X-Gm-Message-State: AC+VfDwiExsw3ZXVdMhCx6ooyIVxPSnOV2oDWsYiQF6sN9y7vS8XwRkG
	YmvzFAkImKSA/mjHiqudqw==
X-Google-Smtp-Source: ACHHUZ5ZG5gVKtbdVz+8h7MvOXDqB764gU3XIbjN7vKlN7mnPdcUHX4Ps85YdIbonO/JMglP01asKg==
X-Received: by 2002:a4a:2401:0:b0:547:6105:e096 with SMTP id m1-20020a4a2401000000b005476105e096mr959488oof.7.1684509935035;
        Fri, 19 May 2023 08:25:35 -0700 (PDT)
Received: from [127.0.0.1] ([52.171.137.247])
        by smtp.gmail.com with ESMTPSA id y26-20020a4ae7da000000b0054f9f229bddsm1518263oov.15.2023.05.19.08.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 08:25:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230519135821.922326-2-leitao@debian.org>
References: <20230519135821.922326-2-leitao@debian.org>
Subject: Re: net: ioctl: Use kernel memory on protocol ioctl callbacks:
 Tests Results
Message-ID: <68711854-61ee-3892-ba5a-136c73b8aff0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 May 2023 15:25:33 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Breno,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_fastopen =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6416256383844352
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6416256383844352/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5008881500291072
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5008881500291072/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 6 failed test(s): packetdrill_add_addr packetdrill_dss =
packetdrill_fastopen packetdrill_mp_capable packetdrill_sockopts =
selftest_diag =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6134781407133696
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6134781407133696/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5571831453712384
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5571831453712384/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/65a7e8021b1b


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
