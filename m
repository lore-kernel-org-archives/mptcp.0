Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0399023AE
	for <mptcp@lists.linux.dev>; Thu, 24 Nov 2022 09:06:58 +0000 (UTC)
Received: by mail-yb1-f193.google.com with SMTP id l67so1162670ybl.1
        for <mptcp@lists.linux.dev>; Thu, 24 Nov 2022 01:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r3v4mctkSEw+EA3Te9cvedTknjGT6jnHVuhHXjUHPx0=;
        b=TexT0UqTN2vhQlJUZwWQTPZIvbbbDVIKSUeEtXyQ0fCkLp/DBUxFzkcmgQX99A4j68
         wS0N3Xu/r/RPKrVAB8k/tAt8fUZe6Ywg5EzvpPZmfnYDJwIjYhtGE3uKLFwb3IjuT2hW
         7CJFxK6Fyj7PNYDAUjbfkOYuMH157ChSk1IQVypK39Wu0B9RJ6zMS+/NhRx7wwq3vsAR
         0anNpft+HuZKL+b+WsipDcoq/yvgX/XM0u28qFDyMomSCs/ANcQch6pHu08YDw0vFHay
         wwlOQSlAYsyYmoJliMELm0GVKYvvp+bOEp8vIJyZ2xNmNeyPlYC2R9WmNE+zWrXetxXB
         OToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r3v4mctkSEw+EA3Te9cvedTknjGT6jnHVuhHXjUHPx0=;
        b=kuKRLjRdPpbR9F0j1xuMJr6PuSNtxL9myDQLs47F8zcAuWx0SLqNzGa+pKhmwdr1CW
         IVBmTNtB2PNvoeVBSHxpFXQq/Ak7O6jcaVDWYEgaQiv8Wpi9wtGQbd5KMWAvXvWYsf48
         c50BQNyJwqrYk3+SVpXS9Ybn5ldpjkJ4FxB5iy71mqsMPGmGhZWBO6NDyS7bNKjnOUrH
         gCUmn13CAglKqItS1vxt8wbu+zfcZlyicIAk9vYA1hISQLeuNIUpyZf3mgRdb+1s+Sd1
         ath9e3LP1Bi8WzVXRFJBWg8eeY1U+NQcVCk1yGZIELZFqRZT7xKdUObVqyGO5LAATJNI
         hM7A==
X-Gm-Message-State: ANoB5pk4Qi5RuKmdKu0CjyVofmTo1a0M/rii2YpqIjOdr6YWbXFP8U2a
	smimojYntEuUo0tp3DBS3WIo/8Attfe63qluTuFcXH51TUkd7Q==
X-Google-Smtp-Source: AA0mqf7bV6zAS/2fBEVAGZwSTUC9PGGw3P/me0T7QkB4k7AA6ig4wh7V1wrFqJvrMk+4oNgCEfZ3iPd7hHrMXeadMZY=
X-Received: by 2002:a25:6b04:0:b0:6dd:51d0:fc6d with SMTP id
 g4-20020a256b04000000b006dd51d0fc6dmr30191481ybc.285.1669280817902; Thu, 24
 Nov 2022 01:06:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221122034923.804955-1-imagedong@tencent.com> <0b86b2b1-1a5c-d500-fd79-c23f2fd4a5ed@tessares.net>
In-Reply-To: <0b86b2b1-1a5c-d500-fd79-c23f2fd4a5ed@tessares.net>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 24 Nov 2022 17:06:46 +0800
Message-ID: <CADxym3axbs=a5Xw=0NW1t225MLqY42M47qQiSu_SuLJ+R_KtbQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v7 0/4] mptcp: add statistics for mptcp socket
 in use
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mathew.j.martineau@linux.intel.com, mptcp@lists.linux.dev, 
	Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

On Wed, Nov 23, 2022 at 11:58 PM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Hi Menglong,
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
>
> Thank you for this new version!
> I was waiting the feedback from the CI to start my review but it looks
> like the CI was not able to apply your series [1].
>
> I just applied the series manually, fixed the two conflicts I got and
> sent it to our repo[2]. We should get the results later on.
>

Thank you for what you do :/
Enn....seems net-next is not a good branch for mptcp works,
I'll rebase to mptcp_net-next branch next time.

I notice that the CI contains some failures, which I am not sure
if it is caused by my commit. Could you please have a look?
Here is the summary:

https://api.cirrus-ci.com/v1/artifact/task/6563194622181376/summary/summary.txt

Thanks!
Menglong Dong

> Cheers,
> Matt
>
> [1]
> https://patchew.org/MPTCP/20221122034923.804955-1-imagedong@tencent.com/logs/git/
> [2]
> https://github.com/multipath-tcp/mptcp_net-next/tree/patchew/20221122034923.804955-1-imagedong@tencent.com
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
