Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E86E3482
	for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 03:04:47 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id i1so953737plr.9
        for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 20:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QGkGFQC3kuxYvWo3pRRjxgu9SwaKb6m6buvi4oBcNds=;
        b=nkNYU7hxjRRJxrWyfbLDp71IjUFVdgl+845lx2BTy5FTd/ebrvWwIeAlm19ZcQokXv
         YXWWt+6GtqFogjacro5xCka6mP4ZcGHtRttVqvqanSNq3SZ2Pw3YPiuYxKNbY54Ncpr5
         qM7B7H37UlSks7zov1IRe1PX+0Wi2dgbiNnt7HTWwy4ZPFXNYrTSO/Hu4DplzUYlNkK/
         JS3Ttv7bHjjC6+QqrhFGej9dsf//2N1aiNicgRymILqFH8TPEFKf0zwsOeAYIrsVGumv
         EsIpjNhSlBRGQH6zzvt1GQnQCJcb3sZ022n2kwBz3zyqYqL3XEXZy2VuXA3qliVmaYyj
         7Z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QGkGFQC3kuxYvWo3pRRjxgu9SwaKb6m6buvi4oBcNds=;
        b=KyBG3IHmhtE8VliX+YJKvcfzXNOqvCaZh6xlwrxWvOo28YNUSOc7w4qvbh7nvWgxhd
         3/kuCmccwx7Xv3OC7nqw7XVQ7zwcm73AYtpGRVhXHAWPvfv+FMoilwq/vczI/GRiPZlG
         QvXTW5HIg8SszN1qMo4M+aWLl1ru63OwWJDPGhATth6N5IaHqRy12V6ZCCPpgKO7dUFQ
         XPy2SlPZ41e5NWJ86pO03klDxZ2JZtQVHmptyRxniRUpyEHKQ+AFT4DafbTZzhbMJJ4Z
         qHO8SO7Hw638Vu/NdtKI3zBT6Cl7RG0PXUqZmxNRZLDfxrOnx6rUqx6zeCe2BoYdg/7G
         +nvA==
X-Gm-Message-State: AOAM533m1OVGQMzrlbwqESdP002bkvsy+8hvt6ESnT2Tz3DrqAEn/yf1
	ci7J3JVXA29X6HhV7q/eS2/HFk0r+yCB7NmsUMA=
X-Google-Smtp-Source: ABdhPJzLwh7I7oh99GMrHQLpWIqMvVWob8z09zmvM1iAr01xquhDqP3M7Safao7L6OWa8Lr3/i+IuVW0agWJg56Ifzk=
X-Received: by 2002:a63:ef12:: with SMTP id u18mr26668073pgh.331.1627441487004;
 Tue, 27 Jul 2021 20:04:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1627281326.git.geliangtang@xiaomi.com> <80cc102e-39d8-f779-866e-5772ed2a9f@linux.intel.com>
In-Reply-To: <80cc102e-39d8-f779-866e-5772ed2a9f@linux.intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 28 Jul 2021 11:04:35 +0800
Message-ID: <CA+WQbwv=VuUYoPz0a=eDhnMsD+uP1vr1ZxqV_M+FN1XgQUyryw@mail.gmail.com>
Subject: Re: [MPTCP][PATCH v5 mptcp-next 0/5] MP_FAIL support
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@xiaomi.com>
Content-Type: multipart/mixed; boundary="000000000000b9e27a05c8263fbc"

--000000000000b9e27a05c8263fbc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mat,

Mat Martineau <mathew.j.martineau@linux.intel.com> =E4=BA=8E2021=E5=B9=B47=
=E6=9C=8828=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=888:27=E5=86=99=E9=
=81=93=EF=BC=9A
>
> On Mon, 26 Jul 2021, Geliang Tang wrote:
>
> > From: Geliang Tang <geliangtang@xiaomi.com>
> >
> > v5:
> > - patch 1, change "ret =3D true;" to "return true;"
> > - patch 3, in the single-subflow case, send MP_FAIL and receive the
> >   echo, then temporarily handled by reset.
> >
>
> Hi Geliang -
>
> Thanks for the v5 changes. The changes are looking good in terms of manua=
l
> code review. Since the selftest changes in patch 5 only confirm that
> MP_FAIL was not sent, I'm going to do some testing tomorrow to force
> checksum failures in single and multiple subflow cases so I can check som=
e
> packet traces. It would be good to have some packetdrill checksum test
> cases to cover that, but we don't yet.

I use a similar test for MP_FAIL to force checksum failures. I have put
it in the attachment.

Thanks,
-Geliang

>
>
> - Mat
>
>
> > v4:
> > - just deal with the multiple subflows case, put the single subflow
> >   case into the new 'infinite mapping' part.
> >
> > v3:
> > - respond with MP_FAIL
> > - add single subflow check
> > - add infinite mapping sending and receiving
> > - export/20210626T054902
> >
> > v2:
> > - MP_FAIL logic:
> >   * Peer B send a DSS to peer A, and the data has been modify by the
> >  middleboxes, then peer A detects the bad checksum.
> >   * In the multiple subflows case, peer A sends MP_FAIL+RST back to pee=
r B,
> >  and peer A discards the data following the bad data sequence number. P=
eer
> >  B receives this MP_FAIL+RST, and close this subflow.
> >   * In the single subflow case, using the simple implementation, peer A
> >  sends MP_FAIL back to peer B, and peer A fallback to a regular TCP. Pe=
er
> >  B receives this MP_FAIL, and fallback to a regular TCP.
> >
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/52
> >
> > Geliang Tang (5):
> >  mptcp: MP_FAIL suboption sending
> >  mptcp: MP_FAIL suboption receiving
> >  mptcp: send out MP_FAIL when data checksum fails
> >  mptcp: add the mibs for MP_FAIL
> >  selftests: mptcp: add MP_FAIL mibs check
> >
> > include/net/mptcp.h                           |  5 +-
> > net/mptcp/mib.c                               |  2 +
> > net/mptcp/mib.h                               |  2 +
> > net/mptcp/options.c                           | 78 ++++++++++++++++++-
> > net/mptcp/pm.c                                | 20 +++++
> > net/mptcp/protocol.h                          | 20 +++++
> > net/mptcp/subflow.c                           | 18 +++++
> > .../testing/selftests/net/mptcp/mptcp_join.sh | 38 +++++++++
> > 8 files changed, 178 insertions(+), 5 deletions(-)
> >
> > --
> > 2.31.1
> >
> >
> >
>
> --
> Mat Martineau
> Intel

--000000000000b9e27a05c8263fbc
Content-Type: text/x-patch; charset="US-ASCII"; name="0001-mptcp-mp_fail-test.patch"
Content-Disposition: attachment; filename="0001-mptcp-mp_fail-test.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_krmw4wh50>
X-Attachment-Id: f_krmw4wh50

RnJvbSAwYmQ1ZDI2YjhjZGViMjk2ZGUzZmRmOTNiZDRmMDg3ODFlMDJhODUzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHZWxpYW5nIFRhbmcgPGdlbGlhbmd0YW5nQGdtYWlsLmNvbT4K
RGF0ZTogV2VkLCAxNCBKdWwgMjAyMSAxNToyNToyOCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIG1w
dGNwOiBtcF9mYWlsIHRlc3QKClNpZ25lZC1vZmYtYnk6IEdlbGlhbmcgVGFuZyA8Z2VsaWFuZ3Rh
bmdAZ21haWwuY29tPgotLS0KIG5ldC9tcHRjcC9wcm90b2NvbC5jICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgOSArKysrKysrKysKIC4uLi90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvbXB0Y3Av
bXB0Y3Bfam9pbi5zaCAgfCAxOCArKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwg
MjcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL25ldC9tcHRjcC9wcm90b2NvbC5jIGIvbmV0
L21wdGNwL3Byb3RvY29sLmMKaW5kZXggOGViMjYyNjUwM2Q3Li41OWUwNGY5YzY5MDYgMTAwNjQ0
Ci0tLSBhL25ldC9tcHRjcC9wcm90b2NvbC5jCisrKyBiL25ldC9tcHRjcC9wcm90b2NvbC5jCkBA
IC0xMjc1LDYgKzEyNzUsOCBAQCBzdGF0aWMgdm9pZCBtcHRjcF91cGRhdGVfZGF0YV9jaGVja3N1
bShzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBpbnQgYWRkZWQpCiAJbXBleHQtPmNzdW0gPSBjc3VtX2Zv
bGQoY3N1bV9ibG9ja19hZGQoY3N1bSwgc2tiX2NoZWNrc3VtKHNrYiwgb2Zmc2V0LCBhZGRlZCwg
MCksIG9mZnNldCkpOwogfQogCitzdGF0aWMgaW50IGk7CisKIHN0YXRpYyBpbnQgbXB0Y3Bfc2Vu
ZG1zZ19mcmFnKHN0cnVjdCBzb2NrICpzaywgc3RydWN0IHNvY2sgKnNzaywKIAkJCSAgICAgIHN0
cnVjdCBtcHRjcF9kYXRhX2ZyYWcgKmRmcmFnLAogCQkJICAgICAgc3RydWN0IG1wdGNwX3NlbmRt
c2dfaW5mbyAqaW5mbykKQEAgLTEzNzYsNiArMTM3OCwxMyBAQCBzdGF0aWMgaW50IG1wdGNwX3Nl
bmRtc2dfZnJhZyhzdHJ1Y3Qgc29jayAqc2ssIHN0cnVjdCBzb2NrICpzc2ssCiBvdXQ6CiAJaWYg
KFJFQURfT05DRShtc2stPmNzdW1fZW5hYmxlZCkpCiAJCW1wdGNwX3VwZGF0ZV9kYXRhX2NoZWNr
c3VtKHRhaWwsIHJldCk7CisKKwlwcl9kZWJ1ZygiJXMgaT0lZCIsIF9fZnVuY19fLCBpKyspOwor
CWlmIChpID09IDIwKQorCQl0YWlsLT5kYXRhX2xlbiA9IDE7CisJaWYgKGkgPiA0MCkKKwkJaSA9
IDA7CisKIAltcHRjcF9zdWJmbG93X2N0eChzc2spLT5yZWxfd3JpdGVfc2VxICs9IHJldDsKIAly
ZXR1cm4gcmV0OwogfQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L21w
dGNwL21wdGNwX2pvaW4uc2ggYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvbXB0Y3AvbXB0
Y3Bfam9pbi5zaAppbmRleCA1NTFmY2NlN2MyZjIuLjg0OTVjYTU0ZDU2MyAxMDA3NTUKLS0tIGEv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L21wdGNwL21wdGNwX2pvaW4uc2gKKysrIGIvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L21wdGNwL21wdGNwX2pvaW4uc2gKQEAgLTkyNyw2ICs5
MjcsMjQgQEAgY2hrX2xpbmtfdXNhZ2UoKQogCiBzdWJmbG93c190ZXN0cygpCiB7CisJIyAxIHN1
YmZsb3cKKwlyZXNldAorCWlwIG5ldG5zIGV4ZWMgJG5zMSAuL3BtX25sX2N0bCBsaW1pdHMgMCAy
CisJaXAgbmV0bnMgZXhlYyAkbnMyIC4vcG1fbmxfY3RsIGxpbWl0cyAwIDIKKwlydW5fdGVzdHMg
JG5zMSAkbnMyIDEwLjAuMS4xIDAgMCAwIHNsb3cKKwljaGtfam9pbl9uciAiMSBzdWJmbG93IiAw
IDAgMAorCisJIyBtdWx0aXBsZSBzdWJmbG93cworCXJlc2V0CisJaXAgbmV0bnMgZXhlYyAkbnMx
IC4vcG1fbmxfY3RsIGxpbWl0cyAwIDIKKwlpcCBuZXRucyBleGVjICRuczIgLi9wbV9ubF9jdGwg
bGltaXRzIDAgMgorCWlwIG5ldG5zIGV4ZWMgJG5zMiAuL3BtX25sX2N0bCBhZGQgMTAuMC4zLjIg
ZmxhZ3Mgc3ViZmxvdworCWlwIG5ldG5zIGV4ZWMgJG5zMiAuL3BtX25sX2N0bCBhZGQgMTAuMC4y
LjIgZmxhZ3Mgc3ViZmxvdworCXJ1bl90ZXN0cyAkbnMxICRuczIgMTAuMC4xLjEgMCAwIDAgc2xv
dworCWNoa19qb2luX25yICJtdWx0aXBsZSBzdWJmbG93cyIgMiAyIDIKKworCWV4aXQKKwogCXJl
c2V0CiAJcnVuX3Rlc3RzICRuczEgJG5zMiAxMC4wLjEuMQogCWNoa19qb2luX25yICJubyBKT0lO
IiAiMCIgIjAiICIwIgotLSAKMi4zMS4xCgo=
--000000000000b9e27a05c8263fbc--
