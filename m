Content-Type: multipart/mixed; boundary="===============5989846081161146003=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/2] mptcp: add MIB counters
Date: Wed, 02 Oct 2019 22:02:00 +0200
Message-ID: <cd7e3f04-c0ac-ed71-84e7-25bd5fc6f0ca@tessares.net>
In-Reply-To: alpine.OSX.2.21.1910011026270.22340@syitbare-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2000

--===============5989846081161146003==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Paolo, Mat,

On 01/10/2019 19:26, Mat Martineau wrote:
> =

> On Mon, 30 Sep 2019, Florian Westphal wrote:
> =

>> As mentioned earlier, here is v2 of the MIB counter patch set.
>>
>> I've tossed all counters that aren't used (=3D have no spot that
>> increments them).
>>
>> Tests still pass, counters get incremented, you can show them
>> via 'nstat' or "netststat -s".
>>
> =

> Thanks for the updated patches, Florian. v2 looks good to me.

Thank you for the patches and the reviews!

Just added at the end of the series.

I confirm that the tests are still passing!

Cheers,
Matt

> -- =

> Mat Martineau
> Intel
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5989846081161146003==--
