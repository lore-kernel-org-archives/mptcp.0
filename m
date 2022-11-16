Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390DB7C
	for <mptcp@lists.linux.dev>; Wed, 16 Nov 2022 01:01:12 +0000 (UTC)
Received: by mail-il1-f176.google.com with SMTP id z9so8374885ilu.10
        for <mptcp@lists.linux.dev>; Tue, 15 Nov 2022 17:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2vJh7KiukqRhWBzyA2CXykjOlyrl7kVJCDlBUGVWpQ=;
        b=V+yQigV0Us3fq58T0gbbmiUE32je53aiA4QSjqS+Xdif0q7hba8wXFg07SP0NMAwsH
         NaCgGp7KtQDqcd2Pm+YGZ2eWcUmS+/InaJFJ09AzjqF4oNBHLONk2GKCsJQyrafCLqU+
         CekcuYcgfVYLbjwzdsgDJa8K8kskrqNTkyULjTEm9a0kq5iZsL5ZLm2g5MKF1TKeL8Ap
         upAOt9UBScsQRyfSnIxS0SdhEWeWva22F9oLn0+frseeV8qj6Ezag2OxGlAeCjs8eLUn
         vKLUqIeh9JjmONennoaI/botNl6WlpiBkIQMbshy/o7ro9lo0IRS6om3x1n4T1IDIMCD
         5Jug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I2vJh7KiukqRhWBzyA2CXykjOlyrl7kVJCDlBUGVWpQ=;
        b=pZgtiyki3dOzLs+IY+FiqoxLZZSYO7MpQdVEiJvy6ZqlfuAWS+SfKvmfyJm0BSUtjH
         aUFbD47Tvke23auzt10gLY9RWoj/Mh/oKilWaq24iS2FFFMXxMNcI8dYUycJlv2sfrNK
         +omfI1/ZfqYANW5/gwmy37GyCb7HsOeoKOhiS1mPNtFf9IZGqOsgVOm4l3E4ceqyaJB7
         +0dhd3rRhW98OyJJm1Bhk4yR7wQLJPqCdo80RU3q0HbAye6rvSBcTZHyKmkhjXljOS/f
         Hiax5iU+KWT3HpkpmYzZKAufa5mTm45PU/uJEOk6ODNrmj7MX/Tp9y25VuJG83/wPpBZ
         T5tw==
X-Gm-Message-State: ANoB5plrzLZcW24x4CZPhXM3q1tPnIIJRZa3P8FhxUDuy+fBclpszwIu
	fQ0db0I7/JJ98g8pRp6TmA==
X-Google-Smtp-Source: AA0mqf6bz3ec72+u4DmrarPncLLreh4958lYZbf5XdKggiC4LaNoIb/u+/1dYp/j8uB0H2pDwCkjhQ==
X-Received: by 2002:a92:cb08:0:b0:302:4ba1:188b with SMTP id s8-20020a92cb08000000b003024ba1188bmr7380023ilo.62.1668560471297;
        Tue, 15 Nov 2022 17:01:11 -0800 (PST)
Received: from [127.0.0.1] ([13.89.246.10])
        by smtp.gmail.com with ESMTPSA id y2-20020a056602048200b006bcbeddb6e5sm5747519iov.32.2022.11.15.17.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 17:01:10 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d1d8d0acb444c6ac39eb6ae945bf439d633e74b3.1668151131.git.geliang.tang@suse.com>
References:
 <d1d8d0acb444c6ac39eb6ae945bf439d633e74b3.1668151131.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_Add_?=
 =?UTF-8?Q?bpf=5Frr_scheduler=22=3A_Build_Failure?=
Message-ID: <d8266a35-2174-e41d-3448-9871c57963bb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Nov 2022 01:01:10 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/d1d8d0acb444c6ac39eb6ae945bf439d633e74b3.1668151131=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/3475381466

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/4174181fc8=
4f

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
