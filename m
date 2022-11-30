Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771F27E0
	for <mptcp@lists.linux.dev>; Wed, 30 Nov 2022 02:11:21 +0000 (UTC)
Received: by mail-yb1-f193.google.com with SMTP id o127so4374335yba.5
        for <mptcp@lists.linux.dev>; Tue, 29 Nov 2022 18:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lJ+GMF0tV1YuOM5C8Or0xTaDwX7fWo9EyHM9dsNgWDw=;
        b=jYlKyV8smyR5bvuEdYyLrNqBE9Vq2elXvHaYBWJpJ3Q3v45Bk4jQNi4aDIVp26VC4A
         kmSlcHgr27ENeaNmqmioioEq2hLNb34/9EtX6kq+CPr6h8xtpbJHNd1c3MC1SeEouWSP
         vYOQcQOlzm3Hgz+WNMGFuaNhbwKlWSsWAb3+9fbimUn7KFpCzpFi8FpRfq5S6JRqaC1M
         rpEfRw9uZkGECsWytM4HFcUCuAFBdzsQMxVYL29XZSvm8PvWNVsSRQKBw82G+ae5T/5f
         KmK+lx7EgZ5HOo7XqXIW6pM3V9xQqz2nYIPZ0IxFMGSHJwLY6aCGMaEQNT6fO1BpC3TW
         MqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJ+GMF0tV1YuOM5C8Or0xTaDwX7fWo9EyHM9dsNgWDw=;
        b=ix2Dv56pgVdZ58AET/1cI+Lmnbi/1QxusqnYteAbhBftPP8bE037FxJyfBElyLsEeK
         uWxvoKn7j+eT8qMm7MN8SV1RSV8l+IqDEZX4bMLmeSk4Gxbs3Pr6CQeocP+tfAM3VOQC
         aujwXN1dDz2IP7je/NrCucXEYDPyDwVIx80tZ0F26o8kdXLmt8bboFsXzHCjK+P/+/BB
         QquXais3bRpLmy7PXCzafEQ10O6+iXEcC314TC3s7bXv/yCpInw5+XlGhO3ZnFNtw5Ab
         wOOKAg17a6cfAmmBY+28unumm1CnukDcU1m05+6V5kg5ZIeaW9Yi+BknO4KSwV6lnmSs
         lzuA==
X-Gm-Message-State: ANoB5pk/JHAWSknByycz5V2q1rqm6xodx+9oyaEM39P4zDfq37zJVHQ+
	EjzuHnnhw5bKVz/H1fYNYONMa6uZ8mm6Afpcxr0=
X-Google-Smtp-Source: AA0mqf5brd2+J4F8j80AF7KTo7RCglZkp8OflIzw7li2pdLRqK6XaI4DHSSNM56Mo1lK4siNDfbmLAPvq9LK6s2BjdI=
X-Received: by 2002:a25:76c4:0:b0:6f1:e850:f633 with SMTP id
 r187-20020a2576c4000000b006f1e850f633mr27764400ybc.231.1669774280480; Tue, 29
 Nov 2022 18:11:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221122034923.804955-1-imagedong@tencent.com> <9a04313e-9874-ff64-64a5-d1d367125dc7@tessares.net>
In-Reply-To: <9a04313e-9874-ff64-64a5-d1d367125dc7@tessares.net>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 30 Nov 2022 10:11:08 +0800
Message-ID: <CADxym3YeaTuXQUdoacMRqfkZPL6EjV2av3qdaXENUthA1bVprQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v7 0/4] mptcp: add statistics for mptcp socket
 in use
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Menglong Dong <imagedong@tencent.com>, mptcp@lists.linux.dev, 
	mathew.j.martineau@linux.intel.com, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

On Tue, Nov 29, 2022 at 12:05 AM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Hi Menglong Dong,
>
> On 22/11/2022 04:49, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > In the 1th patch, we do some code cleanup with replease 'sock->sk'
> > with 'sk'. In the 2th patch, we add statistics for mptcp socket in
> > use. In the 3th patch, we make mptcp_connect can exit when receive
> > 'SIGUSR1' with '-r' flag. And in the 4th patch, we add the testing
> > for this commit.
> >
> > With the commit e8695e504942("mptcp: don't orphan ssk in mptcp_close()"),
> > I belive that the testing of diag.sh can pass now. In fallback and
> > simultaneous close case, the msk can't release normal (sometimes?) without
> > that commit, and makes the testing fail. Enn...let's just see that the
> > CI is saying~
> >
> >
> > Changes since v6:
> > - check all processes exit in flush_pids() in the 4th patch
>
> Thank you for the new version!
>
> We discussed about this series at the last weekly meeting we had and
> globally, it looks good.
>
> However, Paolo mentioned that it is a bit of a shame we need to increase
> the complexity of the code for the stats. I agree with you but during
> the meeting, we didn't find obvious better ways to avoid having to add a
> new flag. I will let a bit more time for Paolo just in case he has
> another brilliant idea :)
>

Thanks for your discussion on this topic! It is indeed not a good
idea to add a new flag for such a case. Looking forward to having
a better solution from Paolo.

(BTW, it's all right to reject this series if it's not good enough :/ )

> Other than that, I have some small suggestions for the patch 4/4 but I
> can do the modifications when applying the patches later if no other
> modifications are needed.
>

Yeah, thanks! I can send a v8 too if you prefer :/

Thanks!
Menglong Dong

> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
