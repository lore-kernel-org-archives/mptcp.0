Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEFF19B
	for <mptcp@lists.linux.dev>; Sat, 22 Oct 2022 09:11:10 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso4892084pjc.5
        for <mptcp@lists.linux.dev>; Sat, 22 Oct 2022 02:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDuaes17N+Dn8N7yOjYvoU2PIqMtpZZ8X8JbKEf5ywI=;
        b=dNs6FORsi4wjsOak562nTiWo08s2e83O6/zcsvdShI+u97GXLRIppyi/AfBJvr/fr/
         tLN76pcO6Y0nxVlW/CeQOv5IxI69w5/bMHd8vYnSXv2ZVnT8tP0IEs1kzmOpfol32VPE
         wp6AkHIOYPk+W4bWWbZejpgBZ76RoPgOIHGuEmH0iSufTEnRJ56p29NA2M4ew4kbEhlJ
         f/3TOVoh5ShyaYhSKr0gytX2TDHY1KL91OjSlejNZxdGkDu70t8vw907f+a/lhtoF3Lq
         wP5csEZ41Q/1AxOCodeGYbEb2osGmHUhsJUeP0K7Dn9PgAsFbGB67gfzukxc9jFiUPJW
         zYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yDuaes17N+Dn8N7yOjYvoU2PIqMtpZZ8X8JbKEf5ywI=;
        b=A3pWDENmR8iyNE2u1CqI3WzuTl0EI6FMOLcwoo3pLZoPewcW6rHFUKPqha8WUo3jxb
         czJNy444BZanmDxOYYseeeuAoV5Dr/lXxjOw3qCJych6a+XMsNBh0pICLmnl+alI5Rv1
         mFQc0HusfZREZwZDhCoxu3MIXnCLC3ybHV4snVGxOGHTS0yryzfWMIj29bQU2DVjAXTt
         GsZFj+EtP70dbONgg8Zu8SpnVfTGrrUP4QkgE5hqAKARk/QvaHyw1dGtv2fXXKkzHyg5
         kLIjf93Fr9oPooZT88sCV8TageIJ7Zc7bi8dJBBWF8RdNkXtrD8vGuGcGwMUumq+ljza
         630w==
X-Gm-Message-State: ACrzQf1QZYc6xa6fIoO5L+vQr0+mMG7kYaOB5sdxHINM3eTGlpDy2aj7
	UgP8qsKdtzROgl6TcSy2z/vPG1pQ1WGZ
X-Google-Smtp-Source: AMsMyM4OI+qjYkduFo874/iFIZBhNr79cW4L1H8XAMZFep6VMk3/iwYgEJLAnQTj33EMcHgkoy1vjg==
X-Received: by 2002:a05:6214:5cc5:b0:4b3:dd79:cc7e with SMTP id lk5-20020a0562145cc500b004b3dd79cc7emr19487661qvb.76.1666429859418;
        Sat, 22 Oct 2022 02:10:59 -0700 (PDT)
Received: from [127.0.0.1] ([20.65.93.85])
        by smtp.gmail.com with ESMTPSA id x6-20020a05620a448600b006eecc4a0de9sm11537528qkp.62.2022.10.22.02.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 02:10:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: wangjianli <wangjianli@cdjrlc.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221022070527.55960-1-wangjianli@cdjrlc.com>
References: <20221022070527.55960-1-wangjianli@cdjrlc.com>
Subject: Re: net/mptcp: fix repeated words in comments: Tests Results
Message-ID: <7390534f-b8a1-6ded-1dc7-c49124001b0c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Oct 2022 09:10:58 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi wangjianli,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6615523631300608
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6615523631300608/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/4574830050148352
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4574830050148352/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1240b7ce4b18


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
