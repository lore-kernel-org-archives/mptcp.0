Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5931C76B
	for <mptcp@lists.linux.dev>; Fri,  9 Jun 2023 17:37:17 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1b0218c979cso7848325ad.3
        for <mptcp@lists.linux.dev>; Fri, 09 Jun 2023 10:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686332237; x=1688924237;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ckk2Y8g7r0FWFfzidotqqGzHHhsnGORdq4SYRQUaGBI=;
        b=QYBqxMSzywgUflLCkL0mVSlrJJ5wbu3R16GcPIN3SqGqZKG0g5u79kDuYzN2xfT8MV
         qiudzPovXH/pRYYoRkn99ADn505fAbFt9cJCX7J8hopNcNSilH6dM3YrnNQ53/cV589Z
         5ODrYYPpNar9Z8d31rrzeCz/XCnQniil2KNqYeRdAzaU4rwP9778ly/SuUFYDrXGjqWx
         B92tbF4anDY2OlkYr4JMbSnRytuRfKpCbKC4C8UpJmJX5+bkc2xKnuYtIHwL44eLcJvm
         lVO6d/rs+PleOoq/ttN6vD6QKsSpfURhAlB0XuO7pBCAbdcQvBz5Ai7KAxFmThva2pEp
         TVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686332237; x=1688924237;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ckk2Y8g7r0FWFfzidotqqGzHHhsnGORdq4SYRQUaGBI=;
        b=cncEPzdOYp1OlN6GkUKzJFXLI3/wMsZojXQmdmdu4yGH5o8IdqgmcC5boWPau6qZrO
         EFZ/YSQHXkflNFrtEA6F+hLNQJMOWg2PewphyU2LGIDxG/w7A6gEStShJKrlwBo/JncK
         m3yZD2+VHtENFTG7kUzORZa6kN53aKZnbFac61sbCCrKI1s806FNrAS07bTtbrxhdPY6
         Ab0saCWbBoHOt/C0ze3iFlKLQ//yK5JAaO8NQu125HbePiq83Os4nWxhMuo6MCihgyn4
         nLnCfNMlCJPsOx41TkzOb/c5/A9yZ90W0oaAfPSoETYWsDjPLi8e7D14SWKqH6lhKXwj
         VoLg==
X-Gm-Message-State: AC+VfDyTJxiV0imuXITg73jhjyJSYGkYW+UNBWqpkOuzOHwhWR3T4XAe
	YcJgTcPut+xX5MNaAlGxwA==
X-Google-Smtp-Source: ACHHUZ6N7faYO7O+YPJ9hfIexUt4jtkWqQn1xFwyp++gCp/O+Xw+OXXSxH6PXoKeT6HNKPdSCP3O3A==
X-Received: by 2002:a17:902:f68d:b0:1b0:5425:2165 with SMTP id l13-20020a170902f68d00b001b054252165mr1894998plg.29.1686332236849;
        Fri, 09 Jun 2023 10:37:16 -0700 (PDT)
Received: from [127.0.0.1] ([138.91.227.57])
        by smtp.gmail.com with ESMTPSA id az5-20020a170902a58500b001b034faf49csm2092287plb.285.2023.06.09.10.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 10:37:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230609152800.830401-1-leitao@debian.org>
References: <20230609152800.830401-1-leitao@debian.org>
Subject: Re: net: ioctl: Use kernel memory on protocol ioctl callbacks:
 Tests Results
Message-ID: <54e69429-3a01-1730-3015-3b30946ff243@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Jun 2023 17:37:15 +0000
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
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6051788479004672
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6051788479004672/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5488838525583360
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5488838525583360/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4574044851273728
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4574044851273728/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5895381003796480
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5895381003796480/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/684c7cd9447c


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
