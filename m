Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6D246AB
	for <mptcp@lists.linux.dev>; Wed,  5 Jul 2023 17:11:09 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-31297125334so931866f8f.0
        for <mptcp@lists.linux.dev>; Wed, 05 Jul 2023 10:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688577068; x=1691169068;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GVptDqaBCIAMoomVhp/ElvTEBq5XtfdsM5eshvBPa2Q=;
        b=ebHj5Tcz9D519UTgs/1pjjH8S+UOQuig/b5HQbMNeIMrlwaxs8LSPFKGaWPWO4FMJ+
         UpOVb8SC4WuQOMTrJCETw+gAB6uec/gKLMMfX7hCViG6ZP7NwC00997ocdGZ95VhBgF8
         UoNFtP47676/sEID7Q0qupbV6uLt1HkCK0PjqyZ7bXUnTwmAvQsm3+zS0z/8bnhS452B
         gXQ2cOFwL5gxqtDtG9ujxGKqyeZEk2d8FKPByVu6qGAsV/tJX9yCz/LY3yALkEm/g90Q
         ED3zTpZhfmZsipDQnhG5Fhm0EZcslrClMkRFS2oc1Fbp3QeD2r1zY+ufKyZXhGPaFpmB
         Ag4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688577068; x=1691169068;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GVptDqaBCIAMoomVhp/ElvTEBq5XtfdsM5eshvBPa2Q=;
        b=QOvKY0No6rGq3syny/X2J46EDdpTCo3J035tAw/jOZlLkCzQVKZci5VEO1U/RU7XqO
         JXALEEnPeV26lRSm/3kbjO82LfIoXojIbvP6v5VOTMvGnm9QOMlfM4r1yyCXMZ1VzMg2
         NWhFdTGyCWRE4nZQc5hnakedVOf7CbCNnzSbo5fgbOv1cxLDK+YJYQdmpszuBbYCJnnC
         QMQBk2BBovVoeKR+M5mlsVF9leIqGNrwfLzXKdqTWlJL/3c8KzeR9c6tKZ9B8+7+9Zv0
         vezhrHjDERDkehkbyM8bUoAIxvxQ4ZPEBc2BX4ljSbTAP8z74WDiLhy+SX/CGdBQ6PYC
         pHyA==
X-Gm-Message-State: ABy/qLZWCAuxpl5LwCFjhjvx2sLhKhsd5ibr74+IO2a9fgVZxdJPKtMC
	n7rbzEmItYVNhZiJRJhx7aIFMZGUumYT/C3TME8EVhEK
X-Google-Smtp-Source: APBJJlH3T09wSboAJ4fwxOTg9yqx/H64eoQJcDRqJ3aJRFKhoPWNtVpM5TycXd3L63DY2gGuLNdEiA==
X-Received: by 2002:a5d:6847:0:b0:314:d00:7352 with SMTP id o7-20020a5d6847000000b003140d007352mr2719987wrw.32.1688577068184;
        Wed, 05 Jul 2023 10:11:08 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00314172ba213sm16993444wrn.108.2023.07.05.10.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 10:11:07 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 0/2] selftests: mptcp: pm_nl_ctl: display errors
 if any
Date: Wed, 05 Jul 2023 19:10:37 +0200
Message-Id: <20230705-mptcp-issue-368-pm_nl_ctl_ack-v1-0-40bcff40cb6b@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA2kpWQC/yXMTQrCMBBA4auUWTuQpqSKVxEJ+ZnqYBtDJpVC6
 d0NuvwW7+0gVJgErt0OhT4s/E4N/amD8HTpQcixGbTSgzorg0uuISOLrITDeMG82DTbUGfrwgu
 970dtJuNjdNAeudDE2+9/g3+aaKtwP44v1rlyYHsAAAA=
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1525;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=HMxUUVA8fDFGS8DQOzBrCDLckT6foKzeBeRT0RdaUBA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkpaQrgInxhwmCZPK8a+yH8DghJAH4r99Uv+Qhg
 /1S3lGTzCiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZKWkKwAKCRD2t4JPQmmg
 czawD/4vCqvLOV8qFNGGJBT9nuLfSS7/AAO+FZReZtAeEkfHXXvvpM/17naVJjMiBXdvVHpMhGh
 kkWIzr1dQI0HITwQbWJfugg05td6M6lmfD+Z8uyH6WlZjioKKOI8RCrnGCuPHMppn8jkDc++FQf
 ZYcigSVoj+MfFImcAn1agg6YHCUlLMtdz9CmdjFCbRplslqiADdyEBEvT7jvqp0eia7+Zwpm3KC
 s5IDgLQYt4Z/UQBn4mytt8SkvNekbAkqnX6Gi7afUKFmMhJj+xd631uieubuTLxr6gD2IlPwLMy
 pWHcK4Hv/SSOlUcOx/MQFi7pSwG/Ejvbqbzq1uo/5nT3gtUgxVQTJwdoYJZpP6o8vmcq4VGOv6A
 W6CDt3TNczWl9L320jby5CGlGmwacCB0QImK5p2wJvxk8dwsfSu5CTbvfZS4a5mqe3OU64atOv6
 5ZKxt2MG8WddBBLe4gdpKhO2qKUCteXR8guEv+9pHHXikts6zBeAJ3KZApt+R6sjqlmS1leLjOF
 +XTSbkm996SR9lMrkoL0XGiIwpSD9oRYPNF+kYey33Z2B+1pmZqsyhzN8IzOJx1PCRqvbOE0iiX
 rI70si2Z99ZZ66uuMl15WJfjJmyhyXJsJ/sMudvtYzahaMExmyzUcltBNyFBKz9ASSN/z3ftS5E
 +3p+fY6qBZ4H39g==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, I wanted to understand why the userspace_pm.sh test was
failing on some arch according to lkft reports. There was nothing in the
logs apart from seeing the expected event had been missing. I then
realised the output of pm_nl_ctl was muted but also this tool was not
looking if there were errors after having sent some Netlink commands.

I don't think it is a good idea to mute the output and ignore errors,
especially here in the tests where we do want to validate these Netlink
commands. So now the tool checks for errors and the output is no longer
discarded.

Note that I didn't manage to read the error message set by the kernel. I
think the rtattr pointer in nl_error() is wrong. I think it should get
info from &err->msg instead of nh. Anyway, here we at least print errno
and just in case someone wants to have a look, it is easy to test:

  ./pm_nl_ctl ann 1.1.1.1 token 12 id 0

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Matthieu Baerts (2):
      selftests: mptcp: pm_nl_ctl: always look for errors
      selftests: mptcp: userspace_pm: unmute unexpected errors

 tools/testing/selftests/net/mptcp/pm_nl_ctl.c     |  33 ++++---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 100 +++++++++++-----------
 2 files changed, 72 insertions(+), 61 deletions(-)
---
base-commit: cde4fa6a0a5ed3effb75008ce99eb842bc448e5d
change-id: 20230705-mptcp-issue-368-pm_nl_ctl_ack-bb1625f5bdda

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

