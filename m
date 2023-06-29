Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E0B1426A
	for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 18:16:10 +0000 (UTC)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3a0423ea74eso708782b6e.1
        for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 11:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688062569; x=1690654569;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zC2NRPOd4ogvEdgvw9ZlI6fAFE9n3GkGOGebcENEMeo=;
        b=gqieHDpKEUFK9MQ5o4ZKRSERMuyjl0C9RBKrIGCqRmE97eh00VhzjCbeJkCFNwqdUi
         cFwVhTDiBBU58ESICkyaq6jn1QaBfu6+RFhrFetz29SaX0QJj5Rq+LBaDrS712Pj402l
         jvRID7mJYI/SENA6f48imbMOBU3ZOeSTB8bcquXjbSnF6fjeWxyFKddgTj/6n+CMFUZb
         0IzbnMNcW+Yh5XmsRW4K3rjZDUkqPVT+v50+wGLbTQX0RTSx5f7cQH/OYGqDkW2DxyJK
         mRK20LP8MNiXBDxGYKBy/ybdZjg3LOI9eSOTSMKbTSCQTT/Ewm1MQ6BbtzxGM53xzqJ+
         X4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688062569; x=1690654569;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zC2NRPOd4ogvEdgvw9ZlI6fAFE9n3GkGOGebcENEMeo=;
        b=fcr3FDcy2i9icOyXwTedSy6kKJDoFzXMFAaUeDL0DikR70Zn2nWKFJ/Cnj/LkvPkik
         fC0Hq6UGQqE1bDPTpxX+ZrR3kjmymrhpbL66AmU4MWFBp3949Jvst+LxGZiHB4Jbq+lg
         MszU04IJhJx9fmhZku//cy5U6U66919mtmbv753Lapj9QRQk+3UmDtYg2TRYMxPVAxBl
         zMZOU28fhYv4ei1WCin2P7AKNYvzyrXHBjv+JBChW4m5b6FVeJ/HKAf6tWDyfmwipC1z
         Jn3/uRjF4+99J+aRw/2NQdB6MoPrp9+JqBaLMXpCYIhMp7f4TSv5IQi/1CMO/TETIiRO
         zxlQ==
X-Gm-Message-State: AC+VfDyZp24rkjfHX0y+KvoipYx35oom+dzl9sxVwr6bqrcuMb0E4vc3
	aTDNx2YbA764sH7W67EuSTc1oqL7x+p7
X-Google-Smtp-Source: ACHHUZ77MLp20mkO44h33fVB1KXCeO2evB7R/5OgJ4fueiWP5UXxGeUDlBuev8AbFLj2t/X7xjvQ7Q==
X-Received: by 2002:a05:6808:1149:b0:39e:60f4:1c0d with SMTP id u9-20020a056808114900b0039e60f41c0dmr245958oiu.28.1688062569445;
        Thu, 29 Jun 2023 11:16:09 -0700 (PDT)
Received: from [127.0.0.1] ([104.210.139.214])
        by smtp.gmail.com with ESMTPSA id x14-20020a056808144e00b00398031b1014sm5824041oiv.26.2023.06.29.11.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 11:16:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230628144927.828117-3-matthieu.baerts@tessares.net>
References: <20230628144927.828117-3-matthieu.baerts@tessares.net>
Subject: Re: selftests: mptcp: join: colored results: Tests Results
Message-ID: <9b5abcdb-c251-83a6-2e5a-7b57d98556f7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Jun 2023 18:16:08 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/6585027727720448
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6585027727720448/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/5368007371784192
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5368007371784192/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/5917564174336000
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5917564174336000/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/5842187364073472
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5842187364073472/summary/summary.txt

Initiator: Matthieu Baerts
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/07c93e69ca2a


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
