Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0227C
	for <mptcp@lists.linux.dev>; Sat, 11 Jun 2022 16:55:12 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id x75so1311463qkb.12
        for <mptcp@lists.linux.dev>; Sat, 11 Jun 2022 09:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=VRnDfrekbMv4XlwuibhXruF79/kMMrpZj92ih98DUKI=;
        b=pkzqBXNTQr0t7NiIV401UZffl8cADfyt/XrZOqJiAnzQHoOFH9PdP+aXFkJ1agEniI
         G9beC65rr94eqUXmi3NIXzH+OoXwrxEqzxmZOyY+mi+QOzHmDPWA89vWCUdZWqWTbnft
         rHHVev4Ostd2cv8feC+m/K2r+X0rOVeoRNKTGV7mT3M/fK97Zr23Hq/sysXkC5+tt/3e
         vI+X03nt7Oven3Tf3e9T+KC4gunTe58q5Q7sow76SktxWzqhWHsl0Ce6jOsDID0FlBC0
         WJJ7dIfpkviLt+w3YfYU9+yBT2qsgBOMer/dgO4/euKaE99a/Eb/HCBHoUaRxmqX29m9
         ENHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=VRnDfrekbMv4XlwuibhXruF79/kMMrpZj92ih98DUKI=;
        b=Jz7GHx2zziDdu624XMOIbp/Af6IBG3UpRg7oNiE28kkw1P8AHRGwbKv7f7VqMkoYe1
         wZhXq78WJuBjQ3S2Uy4LnQxZbBouLyq7YB1bwDZsLkmoQYlefbACMIrgLe+B0P/ZXr8v
         PJSAcbgsLWwTHeyLAdbzyYSAJS8oPEMvewDjHOLpzgFyd3i124VIVECzG+/El0TWVspN
         bUsmMA96Bycj5howwC/zJ/o324mCtTkD6OUmFJFh/VZ69IwZYIXuVCtnpzIVJ7IFvq0N
         AMaW70mwuBTg+Rf2iPXspX9JFw55rvrA1VfZ7h7Vgg4ASUjDrx+Nji0Yq/ZjGTJjR/iC
         nmyw==
X-Gm-Message-State: AOAM533fH58dBG4b8fseqnoqYoYsCI0sXKD+5Lmd4GhnstLiKehKE/PX
	Ye13DCt+8ht41m3mEDIq0kzXSlJv5Tma
X-Google-Smtp-Source: ABdhPJx1JNTXDa2FNAagNn/PidneOFvKAbfdktILQHg65LUGGWqoTbZ3qYEHzR3s+yW2ykWzQCfp1Q==
X-Received: by 2002:a37:bb41:0:b0:6a6:48f4:2814 with SMTP id l62-20020a37bb41000000b006a648f42814mr34602503qkf.421.1654966511122;
        Sat, 11 Jun 2022 09:55:11 -0700 (PDT)
Received: from [127.0.0.1] ([20.232.124.50])
        by smtp.gmail.com with ESMTPSA id 142-20020a370894000000b006a6acd33f18sm2120065qki.8.2022.06.11.09.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 09:55:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <b3ad5c0e791325a441ba76f24ec13a7a8000a28a.1654958401.git.geliang.tang@suse.com>
References:
 <b3ad5c0e791325a441ba76f24ec13a7a8000a28a.1654958401.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: update pm_nl_ctl usage header: Tests Results
Message-ID: <5b3c8d9e-7757-12fb-a519-efcee0e182dc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jun 2022 16:55:10 +0000
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
  - Critical: 7 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/5443636765655040
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5443636765655040/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/6569536672497664
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6569536672497664/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/663169e99df0


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
