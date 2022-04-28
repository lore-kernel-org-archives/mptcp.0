Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA2FA20
	for <mptcp@lists.linux.dev>; Thu, 28 Apr 2022 06:52:24 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id bg9so3236817pgb.9
        for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 23:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=YsjHls0iutfLcXjEkmE59ylk55flIHwJOOUqjES0uSk=;
        b=MXfS6/XRcR0uK+KM+AeKHWTpHOxgWqNdvPQdjmbLxqrH5Bioewa9MHgncJWFFQITk7
         BG7Nx1g18cH33EUKFzmkFJslqCrB9zaDOTq1+LJSQAgyUsTlzFd+5GxWuEwxkJZ+5fF8
         V8Ud/qnandVqEA9iotc8ODzpfTGZT+kcoZU9iFd8orPbPCfYQo9xAi1wm3l8sbgghqPI
         l4M4kEAEcYTKkGKN2v+FgAkTSovFXDaJI1NaaNM3vv2mgN0RQepVvKKMZHAsowI0gQn2
         17thphqBlJkxPrJ2UYtXdR3n7aFzKQEjRnoZq9P1MXF5WaFeUlMnWOau7RCkpxLOP3QW
         lraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=YsjHls0iutfLcXjEkmE59ylk55flIHwJOOUqjES0uSk=;
        b=GMIpZ9tu4tsbRb8lsoJjhIXHSRIu4tJG8YxqKGeuphbR6R9JNRVtLpP6lZwG9OvVsx
         y+MFAxk2fvuLo/k2h9kELFL/C6C3VtpthrttSjoPfE7RI6C5svH+UhqCM8WZvqgg3juO
         WmRtUB3H3PIe54SN/Lz/uq1sC0yapCKXdbSA/wFCVGuh1EvHXXANvcatqqFWcOZpCRG0
         a7y0L4HOmpvi+nJ1jIVqcosGP0Aj0NgbiyYtz17i5gi/OVSoUHdrgvlHA4BfyV0J528C
         ofUdvTZxMDTtgyilF+FTe4sebVtLV/ZmwiSbhY7V+EHwN77fr5eKAZAat3riS7uaNHFi
         ul0w==
X-Gm-Message-State: AOAM532MXadihwQ6keFf9fQbg7SJG+48neQs8qAos84bejVg4udDYuLf
	/FBGtt5sF82OxziQCHNepg==
X-Google-Smtp-Source: ABdhPJxtOmggsAS8NMMiUBG38uDHjp+G0hUVcSK24yMoZ7HYFQ6Q2MZu9iPfDMKlOorqGu4selUSNQ==
X-Received: by 2002:a63:105:0:b0:3ab:e98:5844 with SMTP id 5-20020a630105000000b003ab0e985844mr19875697pgb.218.1651128743978;
        Wed, 27 Apr 2022 23:52:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.64.131.73])
        by smtp.gmail.com with ESMTPSA id n21-20020a634d55000000b003c14af50617sm1502472pgl.47.2022.04.27.23.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 23:52:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <81c493815ed6f4d50b8178323771b97d27fad1f8.1651123078.git.geliang.tang@suse.com>
References:
 <81c493815ed6f4d50b8178323771b97d27fad1f8.1651123078.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: add bpf_first test: Tests Results
Message-ID: <c16651fc-c6b7-5db7-9e35-a5ca9f5fa851@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Apr 2022 06:52:22 +0000
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
https://cirrus-ci.com/task/5388566946643968
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5388566946643968/summary/summary.txt

- KVM Validation: debug:
  - Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/6514466853486592
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6514466853486592/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4c685a27f844


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
