Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7911AFD4
	for <mptcp@lists.linux.dev>; Wed, 29 Mar 2023 10:05:24 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id q19so11978018wrc.5
        for <mptcp@lists.linux.dev>; Wed, 29 Mar 2023 03:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680084323;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JFyvukBxhDwLt7y573MJz5ybLOFK0qfAYQ9zDO7qEnA=;
        b=YvE9B4AZ09Ysw9hR451ksMU8t7uqEJhDup7DQOmZ6IygCdhS3om1QlpeOSthhqf1lx
         +TsCAGfMgj8RRQ2GtgxIJk0w7fGDJhvBWBa1+/nojpuoHCCve68rjc37m06JZr8Zu5q6
         1tUCSQ6q0RP1tLR7zJ52ey9F6YuQBkXQgMzOUu963WxUS1XDc8793g3+PS8ycVsaPwCY
         W2vzXKKFLJjTRl7yvTFc4/KbzCet1XgTiMXso5uEYE+tS+v1oRC0XX3/XuW6wJuzFNFZ
         ucuEmQ1rThK021D5RrazPVSD0RWbQ+wlNqM5Ud9qfazu40nSGH9aJUU6r1HwA1NjGmrt
         g+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680084323;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JFyvukBxhDwLt7y573MJz5ybLOFK0qfAYQ9zDO7qEnA=;
        b=PdoifUHBzQYnlusRLgDxffg6qBKL84/PpYeLotWy86HOSl7ajahSvGjme7lOZaIZvw
         hL9wlJK4B8rvA/PCqurTaKehXf/pOHxbb+1dD1VtfglFRM3svpVS/qMX2PJa8vfu2ys2
         xHpZioj/bZ/UNR6qv9MAJRVe89xzV8Wrna7sTUSWk3Zgvf25EnDhA5/LLZOAr/gcssh6
         lI/C2YmeVz3xnRaeJyDr5qZN02NmWWztHGezKH59pbEI3lWqlSXFrqVnUSbgMWA8lfei
         C2MWAEhktMgCm3t9bSmZxemHJd18ZnfRQOZEiT7LMFXJPzIswwjT6znmibJbF23Dd5r5
         0Rrg==
X-Gm-Message-State: AAQBX9cMxA/1U7JGek7XwU4kCsQZuHI9JuDPNDVxT3lhPM75rAEk41pC
	ta0T/ZAOColJceX104de93e0/TPsptSxvWYWtFNkW/v9mRA=
X-Google-Smtp-Source: AKy350b2e1xZUvoLDoW8uL22PHqtvfS+Uck+1yD63ENV5Mm20qBYNvKtyayPpfiUcjGofwOEO5/8+hkrkP2XhjaU2Yc=
X-Received: by 2002:adf:eb85:0:b0:2d3:c90e:88c3 with SMTP id
 t5-20020adfeb85000000b002d3c90e88c3mr3869286wrn.13.1680084322846; Wed, 29 Mar
 2023 03:05:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKdABxssnqVYwgJnhqD4653-n8+aCX1CCqNOxN-EWG+YWaGRyg@mail.gmail.com>
 <c14c5a19-5a88-0dba-b58a-ea5cfe8a6211@tessares.net> <CAKdABxvkQmFDXM8eBqEc-jqFdLuW+yp1_1zexsGez8BrA2JoDg@mail.gmail.com>
 <886b5c3d-53e9-d797-8bd2-aeb809351fe7@tessares.net>
In-Reply-To: <886b5c3d-53e9-d797-8bd2-aeb809351fe7@tessares.net>
From: Iheb Zannina <iheb.zannina@gmail.com>
Date: Wed, 29 Mar 2023 12:05:11 +0200
Message-ID: <CAKdABxupt1=Q5ZQY_tg9j2q68a5bBa3UBY7hEMRNihCBi6a68g@mail.gmail.com>
Subject: Re: MPTCP_Up_Stream
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Content-Type: multipart/mixed; boundary="00000000000041a3e105f8071d5b"

--00000000000041a3e105f8071d5b
Content-Type: text/plain; charset="UTF-8"

!Sure, look at the CC section.

Hi again,

Thank you for the quick answer,

In the https://progmp.net/  ->  progmp_helper.py file (attached).
You can see that to set a Default Scheduler you need to open the "
/proc/net/mptcp_net/rbs/default  " file. Then write the name of the
new scheduler.
What about MPTCPv1? How can I change the Default scheduler?

Yours sincerely,
Iheb.

Iheb Zannina

Software Engineering Student

Engineering | ISSAT Sousse

+216 28 686 956
iheb.zannina@gmail.com
https://github.com/IhebZanina



On Wed, 29 Mar 2023 at 12:00, Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Hi,
>
> Please send your replies to the mailing list as well, not just to me.
>
> Cheers,
> Matt
>
> On 29/03/2023 11:45, Iheb Zannina wrote:
> > Hi again,
> >
> > Thank you for the quick answer,
> >
> > In the https://progmp.net/  ->  progmp_helper.py file (attached).
> > You can see that to set a Default Scheduler you need to open the "
> > /proc/net/mptcp_net/rbs/default  " file. Then write the name of the
> > new scheduler.
> > What about MPTCPv1? How can I change the Default scheduler?
> >
> > Yours sincerely,
> > Iheb.
> >
> > Iheb Zannina
> >
> > Software Engineering Student
> >
> > Engineering | ISSAT Sousse
> >
> > +216 28 686 956
> > iheb.zannina@gmail.com
> > https://github.com/IhebZanina
> >
> >
> >
> > On Wed, 29 Mar 2023 at 11:35, Matthieu Baerts
> > <matthieu.baerts@tessares.net> wrote:
> >>
> >> Hello,
> >>
> >> On 29/03/2023 10:55, Iheb Zannina wrote:
> >>> I am working on MPTCPv1 schedulers in linux V5.15.
> >>
> >> There is only one MPTCP packet schedulers in v5.15. Same in the latest
> >> version. The work is in progress:
> >>
> >> https://github.com/multipath-tcp/mptcp_net-next/issues/75
> >>
> >>
> >>> But I can't find the MPTCP scheduler in "
> >>> /proc/net/mptcp_net/rbs/schedulers " nor the
> >>> " /proc/net/mptcp_net/rbs/default " file.
> >>> Where should I find the schedulers files?
> >>
> >> There is no such things in the upstream version.
> >>
> >> With the fork (kernels < 5.6, [1][2]), there was something under
> >> "/proc/net/mptcp_net/" but no "rbs" directory there. I don't know where
> >> you got that from.
> >>
> >> Cheers,
> >> Matt
> >>
> >> [1] https://github.com/multipath-tcp/mptcp
> >> [2]
> >> https://github.com/multipath-tcp/mptcp_net-next/wiki#upstream-vs-out-of-tree-implementations
> >> --
> >> Tessares | Belgium | Hybrid Access Solutions
> >> www.tessares.net
>
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net

--00000000000041a3e105f8071d5b
Content-Type: text/x-python; charset="US-ASCII"; name="progmp_helper.py"
Content-Disposition: attachment; filename="progmp_helper.py"
Content-Transfer-Encoding: base64
Content-ID: <f_lftir0zp0>
X-Attachment-Id: f_lftir0zp0

ZnJvbSBzdWJwcm9jZXNzIGltcG9ydCBjaGVja19jYWxsCmltcG9ydCBhcmdwYXJzZQppbXBvcnQg
b3MucGF0aAoKZGVmIHNldERlZmF1bHRTY2hlZHVsZXIoc2NoZWR1bGVyTmFtZSk6Cgl0cnk6CgkJ
d2l0aCBvcGVuICgiL3Byb2MvbmV0L21wdGNwX25ldC9yYnMvZGVmYXVsdCIsICJ3IikgYXMgZHN0
OgoJCQlkc3Qud3JpdGUoc2NoZWR1bGVyTmFtZSkKCQlyZXR1cm4gVHJ1ZQoJZXhjZXB0OgoJCXJl
dHVybiBGYWxzZQoKZGVmIGxvYWRTY2hlZHVsZXIoc2NoZWR1bGVyRmlsZU5hbWUpOgoJdHJ5OgoJ
CXdpdGggb3BlbihzY2hlZHVsZXJGaWxlTmFtZSwgInIiKSBhcyBzcmM6CgkJCWNvbnRlbnQgPSBz
cmMucmVhZCgpCgkJCQoJCXdpdGggb3BlbigiL3Byb2MvbmV0L21wdGNwX25ldC9yYnMvc2NoZWR1
bGVycyIsICJ3IikgYXMgZHN0OgoJCQlkc3Qud3JpdGUoY29udGVudCkKCQkjIFRPRE8gbW9yZSBj
aGVja3MKCQlyZXR1cm4gVHJ1ZQoJZXhjZXB0OgoJCXJldHVybiBGYWxzZQoKZGVmIGdldFNjaGVk
dWxlck5hbWUoc2NoZWR1bGVyRmlsZU5hbWUpOgoJd2l0aCBvcGVuKHNjaGVkdWxlckZpbGVOYW1l
LCAiciIpIGFzIHNyYzoKCQljb250ZW50ID0gc3JjLnJlYWQoKQoJCXN0YXJ0SW5kZXggPSBjb250
ZW50LmluZGV4KCJTQ0hFRFVMRVIgIikgKyBsZW4oIlNDSEVEVUxFUiAiKQoJCWVuZEluZGV4ID0g
Y29udGVudFtzdGFydEluZGV4Ol0uaW5kZXgoIjsiKQoJCXJldHVybiBjb250ZW50W3N0YXJ0SW5k
ZXg6c3RhcnRJbmRleCArIGVuZEluZGV4XQoKaWYgX19uYW1lX18gPT0gJ19fbWFpbl9fJzoKCXBh
cnNlciA9IGFyZ3BhcnNlLkFyZ3VtZW50UGFyc2VyKCkKCXBhcnNlci5hZGRfYXJndW1lbnQoIi1m
IiwgIi0tZmlsZSIsIGhlbHA9IlRoZSBmaWxlIHdoaWNoIGNvbnRhaW5zIHRoZSBzY2hlZHVsZXIi
LCByZXF1aXJlZD1UcnVlKQoJYXJncyA9IHBhcnNlci5wYXJzZV9hcmdzKCkKCQoJaWYgb3MuZ2V0
ZXVpZCgpICE9IDA6CgkJcHJpbnQgKCJZb3UgaGF2ZSB0byBiZSByb290IHRvIGxvYWQgYSBuZXcg
c2NoZWR1bGVyLiIpCgkJZXhpdCgpCglpZiBub3Qgb3MucGF0aC5pc2ZpbGUoYXJncy5maWxlKToK
CQlwcmludCAoIkZpbGUgIiwgYXJncy5maWxlLCAiIG5vdCBmb3VuZC4iKQoJCWV4aXQoKQoJaWYg
bm90IGxvYWRTY2hlZHVsZXIoYXJncy5maWxlKToKCQlwcmludCAoIkxvYWRpbmcgdGhlIHNjaGVk
dWxlciBpbiBmaWxlICIsIGFyZ3MuZmlsZSwgIiBmYWlsZWQuIEV4ZWN1dGUgZG1lc2cgdG8gY2hl
Y2sgb3V0cHV0LiIpCgkJZXhpdCgpCglzY2hlZHVsZXJOYW1lID0gZ2V0U2NoZWR1bGVyTmFtZShh
cmdzLmZpbGUpCglpZiBub3Qgc2V0RGVmYXVsdFNjaGVkdWxlcihzY2hlZHVsZXJOYW1lKToKCQlw
cmludCAoIlNldHRpbmcgdGhlIHNjaGVkdWxlciBhcyBkZWZhdWx0IGZhaWxlZC4gRXhlY3V0ZSBk
bWVzZyB0byBjaGVjayBvdXRwdXQuIikKCQlleGl0KCkKCXByaW50ICgiU2NoZWR1bGVyIiwgc2No
ZWR1bGVyTmFtZSwgImxvYWRlZCBhbmQgc2V0IGFzIGRlZmF1bHQuIikK
--00000000000041a3e105f8071d5b--
