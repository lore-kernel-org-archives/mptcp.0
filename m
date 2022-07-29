Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8674A24
	for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 15:47:09 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso5623656pjd.3
        for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 08:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=V++eL7W7VE5sgh5jGIq/XeYcRuT4L3NmmUcLG5i68Cs=;
        b=exClBmqr/dlFFjymyTzcT9l5JbUbNyx4zufhN9GsYz6PbMeKBGUcUWSaqsFPk7CWQf
         FBHFwZlSrGQJgmIWJP7xg6DY+t6xORw1GjoAs8dqAcAFls9FxG0iF1PlHrJ/q5dTQnWW
         Zhlg4F8CMA0T5POc6eCxNuJ+OMTEH2afkDKpdNtgMQ6CV1guWSknAPqazygaHqW1/V4+
         hKescK6m3UoIHAILU3gIggKg3uY5oVr/w9mH38mIymeWcIETOEoRdux+PX+V+sqLO2ok
         wjOoy2Kk7ZdlyDSeos5/Mv14Iqo5fjWSjSj7VR+MxlOjIHuN6CuwzEdHVZ/P1g6uyKky
         K7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=V++eL7W7VE5sgh5jGIq/XeYcRuT4L3NmmUcLG5i68Cs=;
        b=4MqVUcKe42GttphtD/KSBqoOTpYumo7ACRkq9SEhzQ4NMaX4CS6dLbl2lclYdNBN2I
         1IPY+Dl0UPMwWLwSRduujv/15xVZ55NcjFBJCBCoCsGdBvYu98olvuDSuTPjnB0lmnVV
         I41Ojf2FezTfb8/4cgqhIq/fFYTk1hQBhHXvy6SLkL2l9K+pmUPtMoZsz23IBxC4PaSg
         +wd+V7dt/e7zI2zpePQeNsV5Wrya0GzoeIUUU4Hy8ty69vH9urbSGAiWzSPrZtwLidx9
         /aGJ2QFsp0L07z1mM03sDkeZKxsa20RZqzeUEEnN545iHtsA8gbNt0dBwg65Q+s853SW
         xRLQ==
X-Gm-Message-State: ACgBeo0JoOwu6lk+7SpqZWBnXaX5LJ7o5L8+GuPrF7shdlO8ZjLrVZLJ
	8pRGZCbF4os/9rn+ZUza3A==
X-Google-Smtp-Source: AA6agR62mwxtWQ/E37FJsQZXI/5Owh5Ms/W8oFM1GOhn+J65xn1iAaoHmIDK3rdTWwmHlvZjEWA7Pg==
X-Received: by 2002:a17:902:b402:b0:16c:3cab:5910 with SMTP id x2-20020a170902b40200b0016c3cab5910mr4526158plr.96.1659109628959;
        Fri, 29 Jul 2022 08:47:08 -0700 (PDT)
Received: from [127.0.0.1] ([20.253.234.175])
        by smtp.gmail.com with ESMTPSA id k13-20020a170902ce0d00b0016c57657977sm3805533plg.41.2022.07.29.08.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 08:47:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f253e24227ce660aae19714c2cca1726ee087184.1659107989.git.pabeni@redhat.com>
References:
 <f253e24227ce660aae19714c2cca1726ee087184.1659107989.git.pabeni@redhat.com>
Subject: Re: mptcp: use common helper for rmem memory accounting: Build
 Failure
Message-ID: <c42ea753-9808-f3c8-fa7f-ee4fb5055f10@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 Jul 2022 15:47:07 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/f253e24227ce660aae19714c2cca1726ee087184.1659107989=
.git.pabeni@redhat.com/
  https://github.com/multipath-tcp/mptcp_net-next/a=
ctions/runs/2761676692

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/1f45050af0=
65

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
