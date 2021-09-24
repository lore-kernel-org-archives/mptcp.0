Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656F63FCB
	for <mptcp@lists.linux.dev>; Fri, 24 Sep 2021 08:10:33 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id u8so36245572lff.9
        for <mptcp@lists.linux.dev>; Fri, 24 Sep 2021 01:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=FrdliSsvNyfWLu67z8nCyI7LU73GefRzRXgWMXuPrVw=;
        b=CaOsB9KswUv8/+9/6AQ4jDhmMhS4OB8u6IM9JU8wdHqNfUv8iRTEfXKQ7xU8p+/xg6
         nHolQsd+oftEf/XwazIyQ/WBAq5b8BQKq0aVYkgGxAAT3EOAnZldFswk8ewAg2Hrx+QU
         Zv2CmOjAEyZvA3Y4F8eNmWHAeHsjdhLMxp0EBmFBeROWlTpkHoz8ZtPZmdBNlfEunJGH
         2F01RkTrEKECPVQnWMWYjuPiHm31qTEug08UDaWQIrOI+8v4thpKBT91iyowN+CWJfkV
         nMuPSRU9ozTiFvgeivtEuLik2Xw9sCBkwPAoVW+lVz1KSCjXQrRRDjnN+FEvyiH2yUJL
         3vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FrdliSsvNyfWLu67z8nCyI7LU73GefRzRXgWMXuPrVw=;
        b=ZrrcpWeaaGfWgwYP0P02EHYC6dj/TcRyvhxqtMQAqFmsBP6CZ5He2IcLz9Z5HaTuAD
         ZgOPngwd3BkOnMFyd7CqS43gx8Qv7M3u9s7eA+W4pjchxtSPEdgR/Sm2QDfYVB4aPtGF
         +etR5D1nfluv+df2nwNruNKrozxeiCqG0CiQSNxS7ksIsgJi3FCXhTUGCCRxY6C4vddX
         GIza3TEkf2kp3CDyQeR9LG2FWkb4Fj5Uoiet4iBGS/wVy1fapbe83duIpo9uKQzZhghb
         y2oZGsv/ceSxuaufLPdOsRO6lIKxpRJff81Xx8GzAKNsCtJbjIkvfaP58eR+GbG18+t1
         CpTw==
X-Gm-Message-State: AOAM531iYtER0Ad3ZJsGxkuVDuY061gD8vuFVcHhU54BGN8rOAJRTOMA
	mTLu9dy4Cixob+0VOJcfT26uZiz60ZIbLrIHBhMRRCDEv0NqYA==
X-Google-Smtp-Source: ABdhPJw7BiwkPiRsGwl709+BsZqgRC9DnEjZ7IEoFeXhdaMzsNGcmFIp3GrchOoD0H79zJ+nl5kbUNlmmppyaCRZZ0w=
X-Received: by 2002:a05:6512:3f86:: with SMTP id x6mr8262528lfa.389.1632471031256;
 Fri, 24 Sep 2021 01:10:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: parthaz lokesh <parthazlokesh@gmail.com>
Date: Fri, 24 Sep 2021 00:10:17 -0800
Message-ID: <CAJck1w3K8uzVbgmk_UHPPA-T7xh7Gcj_4zdUn-mL-vLZXPoHNQ@mail.gmail.com>
Subject: Help with MPTCPV1 server setup
To: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

I am trying to set up a ubuntu server with MPTCPV1(5.14v kernel). I am
not seeing mp_capable in the syn packet after setting
/proc/sy/net/mptcp/enabled value to 1. Is this expected behaviour?   I
assume ip mptcp commands don't need to be executed for initial
mpcapable subflow. In MPTCPV0 it used to work after setting it to 1.

Mptcp Wi-ki page redirected to this systemtap script. script
https://github.com/multipath-tcp/mptcp_net-next/issues/18#issuecomment-650529642.
But unable to install debug symbol packages(required for above script
to work) for 5.14kernel in ubuntu.

Is there an easy way to enable mptcp system wide and send mpcapable
without tapping the socket with IPPROTO_MPTCP?

Thanks,
parthaz
