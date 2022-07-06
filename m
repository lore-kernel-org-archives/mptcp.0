Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3D946A2
	for <mptcp@lists.linux.dev>; Wed,  6 Jul 2022 12:27:16 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id c13so9773379pla.6
        for <mptcp@lists.linux.dev>; Wed, 06 Jul 2022 05:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=zHVFSEqmrLfLZIUgEbt/rVIQERdCHloms2GUc8YTyYk=;
        b=iHr+XPlZX7R8n139g4OJkFcUWRW0EMIubD1w0E3e7f1NmBUAHsj7vlJj+381m1F9mK
         T+/hwWT6bpO4wIRDJuc7fHbHooI2Kszi+m0s1EQPFHefDfr3rW7g53yg4oe0T+era+QK
         eC9Nt8mQM1hqeypUZzJ/7O1Invr+iMYhDGNhg6pu/9jgWYaVH7VAWQst/l7sugHxbD9j
         2VrM9JDKVLZE8+YFGNwnOv59HzKuC/FZ+QyNJkgSYeNHA1DmTBnmaG7kOz/sNCYls40b
         9ldaNxP1j1ilC+/huKDxhFnETWwA9vLQRBBuXM3FUNLEJu0WklYvpMdmSHWka/UgUpet
         dJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=zHVFSEqmrLfLZIUgEbt/rVIQERdCHloms2GUc8YTyYk=;
        b=5FFKoM5XPqSPTRKVZPGXzC8sX2xVnJcmXMOIO1+Rgz/6f5U+q90aXj4Ukemjo9gi53
         LymYUuoj3zh0c6jvx8LTJjiTxrxiqtXXa0S8Ogc+o6inleC197mtz6QtmpFhxQMXixX2
         WQ3VZLdd/MQDvc2bIBFvCoHg1ba7Jmydnz46uSAc2LMpXjIxEeysAE7L7c4zpD+JHLt/
         1aSe0awnHm8SrNDPD8Q7HAZ96Yw+B1se+kSxHaVZSsrnOZpfsTUC7l+K0V5F88gBAbDt
         2zkBtIQjAJNSUBbZ9Sn00ja1DnBztaGmZx2/ttyU2UtVdBv6fuTTaSFm8LuPdloWU2RJ
         cA8A==
X-Gm-Message-State: AJIora8YxccsCGnbNsrxSvepLURTdHcQz8DEp4I9EqInShCE/Zsf0dsF
	P6BYEVxXvkmU3rFzcrrmIg==
X-Google-Smtp-Source: AGRyM1vCiwPj9h1SD3KLbpzA3M3OpA6Ptkc669amZdl2NZD0NICi8rYmSV9fkH+dR4mpP4kPCY/7gg==
X-Received: by 2002:a17:902:d4c8:b0:16a:480b:b79c with SMTP id o8-20020a170902d4c800b0016a480bb79cmr48180426plg.15.1657110435753;
        Wed, 06 Jul 2022 05:27:15 -0700 (PDT)
Received: from [127.0.0.1] ([20.25.134.11])
        by smtp.gmail.com with ESMTPSA id d11-20020a170903230b00b0016a5384071bsm25701079plh.1.2022.07.06.05.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 05:27:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <2c5147569717a1c879b291230d460e8e85992878.1657106043.git.pabeni@redhat.com>
References:
 <2c5147569717a1c879b291230d460e8e85992878.1657106043.git.pabeni@redhat.com>
Subject: Re: mptcp: fix subflow traveral at disconnect time: Tests Results
Message-ID: <fefaa6fe-c352-93ec-a4da-f235d7e9b8a7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Jul 2022 12:27:14 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/4674580001325056
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4674580001325056/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/5055164154380288
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5055164154380288/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/d9e83c59b762


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
