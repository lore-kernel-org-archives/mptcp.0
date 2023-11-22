Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7423656B75
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 17:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7NK/ukv"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2853347502aso50801a91.2
        for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 09:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700674750; x=1701279550; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkzNTJl7IfnKbqZGG3KaWTh/JVCeZyHcxnRw+iyA9W4=;
        b=E7NK/ukvwiTQCZI9RjWZ07klPlUwOhX9N4kvd9+F5ETWqhtkqtKNWwPvJwP3pbPNi2
         DA4zX2oyQHC38FtC+XK5l0Wt315czmo88pBrjrUyH3XgRbL+C6tpvglBlKh7uyaRK+M1
         4i8dUEpjMIkXN6/vERcK65waNUILfLiyD6kNvt6HMgezMjSErGfkGnXZfTtqagDDXBey
         RzpHDyc7cProJXHIr5khMTWEDnbx3SjT2y+rkEtcNv7fNMqswcO7ej53IBnH3W63X+qL
         kqu5VZ5PViVcEjUHedCR04xN+uorKPrzD0LBTS+QjqzGUA6r1ntjQLSTMPQcHOUzG+1K
         OCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700674750; x=1701279550;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xkzNTJl7IfnKbqZGG3KaWTh/JVCeZyHcxnRw+iyA9W4=;
        b=QrONR4hfoikkOS5mGXa5KT8VR6pqCNjrKflHneRLPEGCeOB7Ji8XBpoDzRpDgD68AP
         8cyjf12cuVw6/1fTJ2Bfr5cYtjd+kO31uooij5o+XpixbCIiJuRHBBpgmuIr34OUN8Xp
         GrefQm3H5SayMd2NRw+5gpMQDhT0bdDMuv2F4fnicGNoctbo34YbuNYRXK42oskhC8p8
         SV8SaL+gQLIIiW5+A5MsW1zeK2fnyiCWq/HK0u5fvzGDWcEB90kQTeLklc9egQKeox4g
         RhytTk2FtGSllC3hcOB3aUrwTnLAJlOC+mn/W4dqJ7y7q/zRgzv/ZOz61qa4nmXXgn+j
         cv8g==
X-Gm-Message-State: AOJu0YwSJFVsEgzGCgA7cXp1XHzcKc7r0cafqTjiPq0CiB1Mz0DBJmzb
	fqMYtUWHDMi4uoH8gHjzNA==
X-Google-Smtp-Source: AGHT+IFHcrQnQUE7LfuhHKwVtk5cC31buvt1/cdYVZLsqmA59gJuDbGnT8P6gr7LJ0tfBOZZ6sMBuw==
X-Received: by 2002:a17:90b:1c92:b0:281:10d:6067 with SMTP id oo18-20020a17090b1c9200b00281010d6067mr3172205pjb.16.1700674749624;
        Wed, 22 Nov 2023 09:39:09 -0800 (PST)
Received: from [127.0.0.1] ([52.157.1.129])
        by smtp.gmail.com with ESMTPSA id dw13-20020a17090b094d00b00285588eabeesm4000pjb.39.2023.11.22.09.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:39:09 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <7237df51ca90d9692f133823a3a6071ee87ba02d.1700667812.git.pabeni@redhat.com>
References:
 <7237df51ca90d9692f133823a3a6071ee87ba02d.1700667812.git.pabeni@redhat.com>
Subject: Re: mptcp: fix inconsistent state on fastopen race: Tests Results
Message-ID: <05b4ffbe-1460-4105-ba45-903d196dc313@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Nov 2023 17:39:08 +0000
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
com/task/4868816103014400
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4868816103014400/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5431766056435712
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5431766056435712/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6557665963278336
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6557665963278336/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5994716009857024
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5994716009857024/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/e7294cdb58da


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
