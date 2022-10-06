Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9242C9D
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 15:43:04 +0000 (UTC)
Received: by mail-qk1-f181.google.com with SMTP id d15so1244748qka.9
        for <mptcp@lists.linux.dev>; Thu, 06 Oct 2022 08:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=wHosZpaBovCsvtwpJ7YpCwQWDaXCHdaUF+ZyAXNlgas=;
        b=OT1R5d1ANIIqBXoIo/J3KgzeToKD4UTCw/3Wq3QItt/1w56alp1lqSWV/XaQyD66RC
         Yraw332gNLz7xZ/FXXvajcxVm5+4gj2HUW+QnQrRWrkXPkP/rWTM/JyUlH1RtQQE2nGb
         CkhLt+ytg0+TAbEB8Tul1nNV2vp+bgfUhWsJCO7uN1YaTkZ3Zqf9DewwKuSWNP8NZ1nc
         5DSyBAtDGJ+0S5VpfnYnVJE6z6pE2Wm18ZSob2Z7IHm4Eg9UiiLohg3j1XM/dCXbuxEU
         kPJH8xGxgfeZx87pubpXHtq7isvRGhrmiVIS8Rq74NLWlrP2uj3EAhoroGmcaA9tQtS/
         8txA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=wHosZpaBovCsvtwpJ7YpCwQWDaXCHdaUF+ZyAXNlgas=;
        b=GovoMd/U4pjYZ79HKIVFZP+7Zjao7Lzbo5Srhn798+WxazfLsuVpkDdOCKu5Oz5qQN
         3Rfaadrz3rFv9xlQQLPnIyeIKK1VgFkMs+8cyvixgp18tY4FK7rp6VqPeWADPFCJR7nU
         LVOtebwJN73QRTXhBhlXs8ddOrMwqkwFREB17CHxLG9Ex9DiL7CLPApF4DxTCZhO8mjP
         38wbYJN/TJT+LMUOSHsBM2JADfGyZ/Sx5Xbkw21kPbkii1KI47Ys/Mqw7mgIS4N8BZ1C
         Yqryk5FzlGZC02lvluEl2CHsr/8QWY8gcrZH42C0Gynl94BoK8TL8HZlXqF2ytusLFpT
         3WNw==
X-Gm-Message-State: ACrzQf2/6iFSf98eQxH1MIZn9lo245ld4R3/FgOUxOuKggAnwcmCdldl
	Y4VOE7SYvsIHB1tytrP5UfeofvC86SXj
X-Google-Smtp-Source: AMsMyM4fiz0Mejth7DU/5cGabADiLnWY4jTmyMzXCejvTfID8E7u7MOJNt71n+vty7JLEDAReLYMyg==
X-Received: by 2002:a05:620a:1b9b:b0:6cf:3c66:8e47 with SMTP id dv27-20020a05620a1b9b00b006cf3c668e47mr585681qkb.478.1665070983575;
        Thu, 06 Oct 2022 08:43:03 -0700 (PDT)
Received: from [127.0.0.1] ([20.10.190.20])
        by smtp.gmail.com with ESMTPSA id v19-20020a05622a131300b0031e9ab4e4cesm18037844qtk.26.2022.10.06.08.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 08:43:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <98389b79ee3e35b87bdba1b82ba409d6f921aa72.1664720538.git.geliang.tang@suse.com>
References:
 <98389b79ee3e35b87bdba1b82ba409d6f921aa72.1664720538.git.geliang.tang@suse.com>
Subject: Re: mptcp: multi subflows retrans support: Tests Results
Message-ID: <7c832235-a0af-ff31-0fca-068fbef501cd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Oct 2022 15:43:02 +0000
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
https://cirrus-ci.com/task/6082444804751360
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6082444804751360/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/5519494851330048
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5519494851330048/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/bc515f11df5d


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
