Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536825390
	for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 18:32:30 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id i3so18003747pfc.11
        for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 11:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2G3zfk8GlSSDI9mtQb+AkXeeFeLFFOA6rzmiCEnypIE=;
        b=n8iqsc2FvwbB8v+ls37cUhGXJvkTTOexMLN9X/CUyLuodL2NTky5L4hSq1BXsRCFkV
         tGs+/BZAfRgYzOQuPc5KDmDYGJ9G2JHgjonS5uTkZ8VsnqMVxwMwHlHQ8i6VCrMKEKLC
         1cZfxG9wr7UDxOuvBiL9RxBFJUBwnCy97D35YhO9sn/Vu4pE4EdizS0PRJapjp2S5cQK
         y7ne7i+8byI/UJo2dV+waRwxtK6p+bc2F98OnhmchLUCSWnAHiZ7Fcr/VppEfPc/QXM5
         HmZwk4ooYU77Lu1QbY7gJOpcGYqce391ntMEySKNrDmcnFZvhDyUz1yPEkb7ljPv2OiZ
         cz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2G3zfk8GlSSDI9mtQb+AkXeeFeLFFOA6rzmiCEnypIE=;
        b=LwJ/P+yeoagRfFxXlCw8AgpSpYg8+sjuU4DHpeDSOc0cVCAJruyR9QOMcXgEoBpY2H
         GTnl7VUiMUoMFYv6TuihSVjT0f0RzzJH9NDYUa45gSt6Wy3ybFnIEosgdBPRCxxgUJyf
         zum/pkDyZABEI2tMT4zhlziJRp7B2e++pEBBzOHd2hfhBgFqhoNNzuE7E16UZ9sVSNF1
         6y7KO+FHYNNqN+EMDZR5W9Anc4tKGzQv+0i5sZG9AnLt5h2hkUmwxIqJukvSlsiAemJu
         bYxf6PbS91ISAXdfwyPRUy2MwCIH4EJqFQUmZOcd5rqZKQJ2K7fiJCqZOQNNFMV5yqX9
         4Erw==
X-Gm-Message-State: ACrzQf0t/Wokg0Ak0+2J5ajdt60eyaAVn1S21eQJXvEysM0q3bSL93Df
	/UV5NISx90Z9+sr+bt8eGb+AAgI0ZceR
X-Google-Smtp-Source: AMsMyM76nkPQ88Y4CuH3Zz5U5LO83S2x/Ne2IV7rKAg0PW3MwrJBfqxWTIClD/XTuaiAjrDW6EwM2Q==
X-Received: by 2002:a63:1455:0:b0:438:e26b:ab1f with SMTP id 21-20020a631455000000b00438e26bab1fmr8092089pgu.183.1666204349762;
        Wed, 19 Oct 2022 11:32:29 -0700 (PDT)
Received: from [127.0.0.1] ([20.115.154.114])
        by smtp.gmail.com with ESMTPSA id z2-20020a17090a014200b0020adf65cebbsm302514pje.8.2022.10.19.11.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 11:32:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221019161940.3178393-5-matthieu.baerts@tessares.net>
References: <20221019161940.3178393-5-matthieu.baerts@tessares.net>
Subject: Re: selftests: mptcp: uniform 'rndh' variable: Tests Results
Message-ID: <71e04737-57e4-d82c-ccc3-8049654af44a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Oct 2022 18:32:28 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/4915441154916352
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4915441154916352/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/6041341061758976
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6041341061758976/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e2fd62b1a03e


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
